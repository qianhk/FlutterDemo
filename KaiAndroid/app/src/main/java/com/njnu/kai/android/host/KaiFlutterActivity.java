package com.njnu.kai.android.host;

import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;

import com.idlefish.flutterboost.containers.FlutterBoostActivity;
import com.njnu.kai.android.host.channel.BatteryMethodCallHandler;
import com.njnu.kai.android.host.channel.DemoBasicMessageHandler;
import com.njnu.kai.android.host.channel.DemoEventStreamHandler;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author kai
 * @since 2021/7/25
 */
public class KaiFlutterActivity extends FlutterBoostActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        final BinaryMessenger binaryMessenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        final Context appContext = getApplicationContext();

        BatteryMethodCallHandler.register(appContext, binaryMessenger);
        DemoBasicMessageHandler.register(appContext, binaryMessenger);
        DemoEventStreamHandler.register(appContext, binaryMessenger);
    }

}
