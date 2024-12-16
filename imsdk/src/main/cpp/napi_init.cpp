#include "napi/native_api.h"
#include "hilog/log.h"
#include "openimsdk.h"
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <sstream>

#undef LOG_DOMAIN
#undef LOG_TAG
#define LOG_DOMAIN 0x494d        // IM
#define LOG_TAG "[IMSDK Native]" // Tag

static void printCharArray(const char *data, size_t length) {
    // 使用 stringstream 构建格式化字符串
    std::ostringstream oss;
    oss << "[";
    for (size_t i = 0; i < length; ++i) {
        unsigned char d = (unsigned char)data[i];
        oss << (unsigned int)d;
        if (i < length - 1) {
            oss << ",";
        }
    }
    oss << "]";
    // 将结果存放在字符串中
    std::string byteString = oss.str();
    OH_LOG_INFO(LOG_APP, "length = %{public}d,data = %{public}s", length, byteString.c_str());
}

napi_threadsafe_function jsEventCallBack;

struct FFIEvent {
    void *data;
    int len;
};

static void eventHandler(void *data, int len) {
//     OH_LOG_INFO(LOG_APP, "recv event length %{public}d", len);
    FFIEvent *msg = new FFIEvent();
    msg->data = data;
    msg->len = len;
    napi_call_threadsafe_function(jsEventCallBack, msg, napi_tsfn_blocking);
}

static void callCallBack(napi_env env, napi_value jsCb, void *context, void *data) {
//     OH_LOG_INFO(LOG_APP, "call callback---------------------");
    if (env == nullptr) {
        return;
    }
    FFIEvent *event = (FFIEvent *)data;
//     printCharArray((const char *)event->data, event->len);
    napi_value undefined = nullptr;
    napi_get_undefined(env, &undefined);
    napi_value argv;
    uint8_t *buffer;
    napi_status status = napi_create_arraybuffer(env, event->len, (void **)&buffer, &argv);
    if (status != napi_ok) {
        napi_throw_error(env, nullptr, "Failed to create ArrayBuffer");
    }
    memcpy(buffer, event->data, event->len);
//     TODO 不拷贝内存
//     napi_status status = napi_create_external_arraybuffer(env,event->data,event->len,nullptr,nullptr,&argv);
    napi_call_function(env, undefined, jsCb, 1, &argv, nullptr);
    delete event;
}

static napi_value init(napi_env env, napi_callback_info info) {
//     OH_LOG_INFO(LOG_APP, "init------------");
    ffi_init(eventHandler, 2);
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
                                             callCallBack, &jsEventCallBack);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "init create_threadsafe_function error");
        return nullptr;
    }
    return nullptr;
}
static napi_value request(napi_env env, napi_callback_info info) {
//     OH_LOG_INFO(LOG_APP, "call request start");
    napi_status status;
    size_t argc = 1;
    napi_value argv = nullptr;
    status = napi_get_cb_info(env, info, &argc, &argv, nullptr, nullptr);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "request args error");
        return nullptr;
    }
    if (argc != 1) {
        OH_LOG_ERROR(LOG_APP, "request args count error : need args count 1");
        return nullptr;
    }
    size_t length;
    uint8_t *buf;
    status == napi_get_arraybuffer_info(env, argv, (void **)&buf, &length);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "request args error 2 : %{public}d", status);
        return nullptr;
    }
//     printCharArray((const char *)buf, length);

    ffi_request(buf, length);
//     OH_LOG_INFO(LOG_APP, "call request end");
    return nullptr;
}


static napi_value drop(napi_env env, napi_callback_info info) {
    size_t argc;
    napi_get_cb_info(env, info, &argc, nullptr, nullptr, nullptr);
    if (argc != 1) {
        OH_LOG_ERROR(LOG_APP, "imsdk:%{public}s", "drop args count error:need args count 1");
        return nullptr;
    }
    napi_value argv[1];
    napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
    napi_status status;
    int64_t handleId;
    status = napi_get_value_int64(env, argv[0], &handleId);
    if (status != napi_ok) {
        OH_LOG_ERROR(LOG_APP, "args error: not int64 :%{public}d", status);
        return nullptr;
    }
    ffi_drop_handle(handleId);
//     OH_LOG_INFO(LOG_APP, "Drop Handle Id %{public}d", handleId);
    return nullptr;
}

// 重定向C标准输出到文件
static napi_value redirect(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value argv[1] = {nullptr};
    napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
    size_t targetDirectoryNameSize;
    char targetDirectoryNameBuf[512];
    napi_get_value_string_utf8(env, argv[0], targetDirectoryNameBuf, sizeof(targetDirectoryNameBuf),
                               &targetDirectoryNameSize);
    std::string targetDirectoryName(targetDirectoryNameBuf, targetDirectoryNameSize);
    std::string targetSandboxPath = targetDirectoryName + "/c_print_log.txt";
    OH_LOG_INFO(LOG_APP, "重定向C输出到文件 === %{public}s", targetSandboxPath.c_str());
    FILE *stdoutFile = NULL;
    FILE *stderrFile = NULL;
    stdoutFile = freopen(targetSandboxPath.c_str(), "a", stdout);
    stderrFile = freopen(targetSandboxPath.c_str(), "a", stderr);
    if (NULL == stdoutFile || NULL == stderrFile) {
        OH_LOG_INFO(LOG_APP, "重创建！");
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
        {"redirect", nullptr, redirect, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"init", nullptr, init, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"request", nullptr, request, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"drop", nullptr, drop, nullptr, nullptr, nullptr, napi_default, nullptr},
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
