package com.njnu.kai.android.host;

import android.app.Application;

/**
 * @author kai
 * @since 2021/7/11
 */
public class KaiApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        CrashHandler crashHandler = CrashHandler.getInstance();
        crashHandler.init(getApplicationContext());
    }
}
