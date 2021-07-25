package com.njnu.kai.android.host;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

/**
 * @author kai
 * @since 2021/7/11
 */
public class KaiApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
//        CrashHandler crashHandler = CrashHandler.getInstance();
//        crashHandler.init(getApplicationContext());

        FlutterBoost.instance().setup(this, new FlutterBoostDelegate() {
            @Override
            public void pushNativeRoute(FlutterBoostRouteOptions options) {
                //这里根据options.pageName来判断你想跳转哪个页面，这里简单给一个
//                Intent intent = new Intent(FlutterBoost.instance().currentActivity(), YourTargetAcitvity.class);
//                FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode());
            }

            @Override
            public void pushFlutterRoute(FlutterBoostRouteOptions options) {
                final Activity currentActivity = FlutterBoost.instance().currentActivity();
                Intent intent = new FlutterBoostActivity.CachedEngineIntentBuilder(KaiFlutterActivity.class)
                        .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                        .destroyEngineWithActivity(false)
                        .uniqueId(options.uniqueId())
                        .url(options.pageName())
                        .urlParams(options.arguments())
                        .build(currentActivity);
                currentActivity.startActivity(intent);
            }
        }, engine -> {
        });
    }
}
