#include <jni.h>
#include <string>
#include "main.h"
#include "ModernCpp/modernMain.h"

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT jstring JNICALL
Java_com_njnu_kai_testc_NdkJniTest_stringFromJNI(
        JNIEnv *env, jclass jclazz) {
    mainEntry(false);
    mainModerns();
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

JNIEXPORT jint JNICALL
Java_com_njnu_kai_testc_NdkJniTest_sum(JNIEnv *env, jclass jclazz,
                                       jint a, jint b) {
    return a + b;
}

JNIEXPORT void JNICALL
Java_com_njnu_kai_testc_NdkJniTest_testCrashInNative(
        JNIEnv *env, jclass jclazz, jboolean crashIt) {
    mainEntry(crashIt);
}

#ifdef __cplusplus
}
#endif