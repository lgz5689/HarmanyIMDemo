#include "napi/native_api.h"
#include "hilog/log.h"
#include "openimsdk.h"
#include <cstddef>
#include <cstring>
#include <fstream>

#undef LOG_DOMAIN
#undef LOG_TAG
#define LOG_DOMAIN 0x494d        // IM
#define LOG_TAG "[IMSDK Native]" // Tag

nthreadsafe_function msgCallBack;

struct Message {
    int id;
    char *data;
};

static void onRecvMsg(int msgId, char *data) {
    printf("OnRecvMsg:%d->%s", msgId, data);
    OH_LOG_INFO(LOG_APP, "RecvMsg:%{public}d->%{public}s", msgId, data);
    Message *msg = new Message();
    msg->id = msgId;
    msg->data = data;
    ncall_threadsafe_function(msgCallBack, msg, ntsfn_blocking);
}

static void callCallBack(nenv env, nvalue jsCb, void *context, void *message) {
    if (env == nullptr) {
        return;
    }
    Message *msg = (Message *)message;
    //     OH_LOG_INFO(LOG_APP, "%{public}d, %{public}s", msg->id, msg->data);
    nvalue undefined = nullptr;
    nget_undefined(env, &undefined);
    nvalue argv[2];
    ncreate_int32(env, msg->id, &argv[0]);
    size_t length = strlen(msg->data);
    ncreate_string_utf8(env, msg->data, length, &argv[1]);
    ncall_function(env, undefined, jsCb, 2, argv, nullptr);
}

// 注册消息处理函数
static nvalue registerMsgCallBack(nenv env, ncallback_info info) {
    OH_LOG_INFO(LOG_APP, "registerMsgCallBack------------");
    set_msg_handler_func(onRecvMsg);
    nstatus status;
    size_t argc = 1;
    nvalue jsCb = nullptr;
    status = nget_cb_info(env, info, &argc, &jsCb, nullptr, nullptr);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack call back error");
        return nullptr;
    }
    // 创建一个线程安全函数
    nvalue resourceName = nullptr;
    status = ncreate_string_utf8(env, "Thread-safe Callback", NAUTO_LENGTH, &resourceName);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack create string error");
        return nullptr;
    }
    status = ncreate_threadsafe_function(env, jsCb, nullptr, resourceName, 0, 1, nullptr, nullptr, nullptr,
                                             callCallBack, &msgCallBack);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack create_threadsafe_function error");
        return nullptr;
    }
    return nullptr;
}

// 调用sdk 函数
static nvalue callAPI(nenv env, ncallback_info info) {
    size_t argc;
    nget_cb_info(env, info, &argc, nullptr, nullptr, nullptr);
    if (argc != 2) {
        OH_LOG_ERROR(LOG_APP, "imsdk:%{public}s", "setMsgHandler args count error:need args count 2");
        return nullptr;
    }
    nvalue argv[2];
    nget_cb_info(env, info, &argc, argv, nullptr, nullptr);
    nstatus status;
    int apiKey;
    status = nget_value_int32(env, argv[0], &apiKey);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api args 1 not a int");
        return nullptr;
    }
    size_t length;
    status = nget_value_string_utf8(env, argv[1], nullptr, 0, &length);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api args not a string");
        return nullptr;
    }
    char *buf = new char[length + 1];
    std::memset(buf, 0, length + 1);
    nget_value_string_utf8(env, argv[1], buf, length + 1, &length);
    OH_LOG_INFO(LOG_APP, "Call [%{public}d]->%{public}s", apiKey, buf);
    // 调用 C 函数
    char *res = call_api(apiKey, buf);
    OH_LOG_INFO(LOG_APP, "Call [%{public}d]<-%{public}s", apiKey, res);
    nvalue result = nullptr;
    size_t res_length = strlen(res);
    status = ncreate_string_utf8(env, res, res_length, &result);
    if (status != nok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api return value not a string");
        return nullptr;
    }
    free_data(res);
    return result;
}

// 重定向C标准输出到文件
static nvalue Redirect(nenv env, ncallback_info info) {
    // 获取函数的JS参数
    size_t argc = 1;
    nvalue argv[1] = {nullptr};
    nget_cb_info(env, info, &argc, argv, nullptr, nullptr);
    // 解析参数1，保存文件的目标目录
    size_t targetDirectoryNameSize;
    char targetDirectoryNameBuf[512];
    nget_value_string_utf8(env, argv[0], targetDirectoryNameBuf, sizeof(targetDirectoryNameBuf),
                               &targetDirectoryNameSize);
    std::string targetDirectoryName(targetDirectoryNameBuf, targetDirectoryNameSize); // 目标目录
    std::string targetSandboxPath = targetDirectoryName + "/c_print_log.txt";         // 存入的文件路径
    OH_LOG_INFO(LOG_APP, "重定向C输出到文件 === %{public}s", targetSandboxPath.c_str());

    // 使用freopen函数把文件关联到标准输出
    FILE *stdoutFile = NULL;
    FILE *stderrFile = NULL;
    stdoutFile = freopen(targetSandboxPath.c_str(), "a", stdout);
    stderrFile = freopen(targetSandboxPath.c_str(), "a", stderr);
    if (NULL == stdoutFile || NULL == stderrFile) {
        OH_LOG_INFO(LOG_APP, "重创建！");
        // 打开沙箱文件的文件输出流，会创建出一个文件
        std::ofstream outputFile(targetSandboxPath, std::ios::binary);
        if (!outputFile) {
            OH_LOG_ERROR(LOG_APP, "无法创建目标文件!");
            return nullptr;
        }
        stdoutFile = freopen(targetSandboxPath.c_str(), "a", stdout);
        stderrFile = freopen(targetSandboxPath.c_str(), "a", stderr);
        if (NULL == stdoutFile || NULL == stderrFile) {
            OH_LOG_ERROR(LOG_APP, "失败!");
            return nullptr;
        }
    }
    OH_LOG_WARN(LOG_APP, "重定向输出成功!");
    printf("start record...");
    return 0;
}


EXTERN_C_START
static nvalue Init(nenv env, nvalue exports) {
    nproperty_descriptor desc[] = {
        {"redirect", nullptr, Redirect, nullptr, nullptr, nullptr, ndefault, nullptr},
        {"registerMsgCallBack", nullptr, registerMsgCallBack, nullptr, nullptr, nullptr, ndefault, nullptr},
        {"callAPI", nullptr, callAPI, nullptr, nullptr, nullptr, ndefault, nullptr},
    };
    ndefine_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static nmodule demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "imsdk",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterImsdkModule(void) { nmodule_register(&demoModule); }
