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

napi_threadsafe_function msgCallBack;

struct Message {
    int id;
    char *data;
};

static void onRecvMsg(int msgId, char *data) {
    printf("OnRecvMsg:%d->%s", msgId, data);
    OH_LOG_INFO(LOG_APP, "RecvMsg:%{public}d->%{public}s", msgId, data);
    Message *msg = new Message(); // notice: memory clear
    msg->id = msgId;
    msg->data = data;
    napi_call_threadsafe_function(msgCallBack, msg, napi_tsfn_blocking);
}

static void callCallBack(napi_env env, napi_value jsCb, void *context, void *message) {
    if (env == nullptr) {
        return;
    }
    Message *msg = (Message *)message;
    //     OH_LOG_INFO(LOG_APP, "%{public}d, %{public}s", msg->id, msg->data);
    napi_value undefined = nullptr;
    napi_get_undefined(env, &undefined);
    napi_value argv[2];
    napi_create_int32(env, msg->id, &argv[0]);
    size_t length = strlen(msg->data);
    napi_create_string_utf8(env, msg->data, length, &argv[1]);
    napi_call_function(env, undefined, jsCb, 2, argv, nullptr);
    // memory clear
    // msg->data 会在函数调用结束后自动释放
    delete msg;
}

// 注册消息处理函数
static napi_value registerMsgCallBack(napi_env env, napi_callback_info info) {
    OH_LOG_INFO(LOG_APP, "registerMsgCallBack------------");
    set_msg_handler_func(onRecvMsg);
    napi_status status;
    size_t argc = 1;
    napi_value jsCb = nullptr;
    status = napi_get_cb_info(env, info, &argc, &jsCb, nullptr, nullptr);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack call back error");
        return nullptr;
    }
    // 创建一个线程安全函数
    napi_value resourceName = nullptr;
    status = napi_create_string_utf8(env, "Thread-safe Callback", NAPI_AUTO_LENGTH, &resourceName);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack create string error");
        return nullptr;
    }
    status = napi_create_threadsafe_function(env, jsCb, nullptr, resourceName, 0, 1, nullptr, nullptr, nullptr,
                                             callCallBack, &msgCallBack);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "registerMsgCallBack create_threadsafe_function error");
        return nullptr;
    }
    return nullptr;
}

// 调用sdk 函数
static napi_value callAPI(napi_env env, napi_callback_info info) {
    size_t argc;
    napi_get_cb_info(env, info, &argc, nullptr, nullptr, nullptr);
    if (argc != 2) {
        OH_LOG_ERROR(LOG_APP, "imsdk:%{public}s", "setMsgHandler args count error:need args count 2");
        return nullptr;
    }
    napi_value argv[2];
    napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
    napi_status status;
    int apiKey;
    status = napi_get_value_int32(env, argv[0], &apiKey);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api args 1 not a int");
        return nullptr;
    }
    size_t length;
    status = napi_get_value_string_utf8(env, argv[1], nullptr, 0, &length);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api args not a string");
        return nullptr;
    }
    char *buf = new char[length + 1];
    std::memset(buf, 0, length + 1);
    napi_get_value_string_utf8(env, argv[1], buf, length + 1, &length);
    OH_LOG_INFO(LOG_APP, "Call [%{public}d]->%{public}s", apiKey, buf);
    // 调用 C 函数
    char *res = call_api(apiKey, buf);
    OH_LOG_INFO(LOG_APP, "Call [%{public}d]<-%{public}s", apiKey, res);
    napi_value result = nullptr;
    OH_LOG_INFO(LOG_APP, "Call result");
    size_t res_length = strlen(res);
    OH_LOG_INFO(LOG_APP, "Call length");
    status = napi_create_string_utf8(env, res, res_length, &result);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "imsdk:call api return value not a string");
        return nullptr;
    }
    free_data(res);
    return result;
}

// 重定向C标准输出到文件
static napi_value Redirect(napi_env env, napi_callback_info info) {
    // 获取函数的JS参数
    size_t argc = 1;
    napi_value argv[1] = {nullptr};
    napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
    // 解析参数1，保存文件的目标目录
    size_t targetDirectoryNameSize;
    char targetDirectoryNameBuf[512];
    napi_get_value_string_utf8(env, argv[0], targetDirectoryNameBuf, sizeof(targetDirectoryNameBuf),
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
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"redirect", nullptr, Redirect, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"registerMsgCallBack", nullptr, registerMsgCallBack, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"callAPI", nullptr, callAPI, nullptr, nullptr, nullptr, napi_default, nullptr},
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "imsdk",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterImsdkModule(void) { napi_module_register(&demoModule); }
