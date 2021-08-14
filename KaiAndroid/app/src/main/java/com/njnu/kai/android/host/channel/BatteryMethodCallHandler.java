package com.njnu.kai.android.host.channel;

import android.content.Context;
import android.os.BatteryManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author kai
 * @since 2021/8/14
 */
public class BatteryMethodCallHandler implements MethodChannel.MethodCallHandler {

    private Context mContext;
    private MethodChannel mChannel;

    public static void register(Context context, BinaryMessenger messenger) {
        final MethodChannel methodChannel = new MethodChannel(messenger, "samples.flutter.dev/battery");
        methodChannel.setMethodCallHandler(new BatteryMethodCallHandler(context, methodChannel));
    }


    public BatteryMethodCallHandler(Context context, MethodChannel channel) {
        mContext = context;
        mChannel = channel;

//        mChannel.invokeMethod("nativeToDart", "paramString", new MethodChannel.Result() {
//            @Override
//            public void success(@Nullable Object result) {
//            }
//
//            @Override
//            public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
//            }
//
//            @Override
//            public void notImplemented() {
//            }
//        });
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getBatteryLevel")) {
            int batteryLevel = getBatteryLevel();
            if (batteryLevel != -1) {
                result.success(batteryLevel);
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null);
            }
        } else {
            result.notImplemented();
        }
    }

    private int getBatteryLevel() {
        int batteryLevel;
        BatteryManager batteryManager = (BatteryManager) mContext.getSystemService(Context.BATTERY_SERVICE);
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        return batteryLevel;
    }
}
