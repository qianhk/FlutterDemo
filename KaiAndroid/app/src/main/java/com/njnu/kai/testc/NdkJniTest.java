package com.njnu.kai.testc;

/**
 * @author kai
 * @since 2021/7/11
 */
public class NdkJniTest {

    static {
        System.loadLibrary("NdkJniTest");
    }

    public static native String stringFromJNI();

    public static native int sum(int a, int b);

    public static native void testCrashInNative(boolean crashIt);
}
