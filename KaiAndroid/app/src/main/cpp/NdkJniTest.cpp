#include <jni.h>
#include <string>

extern "C" JNIEXPORT jstring JNICALL
Java_com_njnu_kai_testc_NdkJniTest_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C" JNIEXPORT jint JNICALL
Java_com_njnu_kai_testc_NdkJniTest_sum
  (JNIEnv *, jclass, jint a, jint b) {
    return a + b;
  }