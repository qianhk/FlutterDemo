package com.njnu.kai.android.host;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.widget.Toast;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import java.util.Map;

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
                final Activity currentActivity = FlutterBoost.instance().currentActivity();
                Intent intent = new Intent(currentActivity, SecondTestActivity.class);
                final Map<String, Object> arguments = options.arguments();
                if (arguments != null) {
                    for (Map.Entry<String, Object> entry : arguments.entrySet()) {
                        final String entryKey = entry.getKey();
                        final Object objValue = entry.getValue();
                        if (objValue instanceof Long || objValue instanceof Integer) {
                            intent.putExtra(entryKey, ((Number) objValue).longValue());
                        } else if (objValue instanceof String) {
                            intent.putExtra(entryKey, (String) objValue);
                        } else if (objValue instanceof Double || objValue instanceof Float) {
                            intent.putExtra(entryKey, ((Number) objValue).doubleValue());
                        } else {
                            intent.putExtra(entryKey, "unsupport type: " + objValue);
                        }
                    }
                }
                currentActivity.startActivityForResult(intent, options.requestCode());
                Toast.makeText(currentActivity, String.format("Native: %s", options.pageName()), Toast.LENGTH_SHORT).show();
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
                Toast.makeText(currentActivity, String.format("Flutter: %s", options.pageName()), Toast.LENGTH_SHORT).show();
            }
        }, engine -> {
        });
    }
}
