package com.njnu.kai.android.host.channel;

import android.content.Context;
import android.os.Handler;
import android.os.Message;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

/**
 * @author kai
 * @since 2021/8/14
 */
public class DemoEventStreamHandler implements EventChannel.StreamHandler, Handler.Callback {

    private EventChannel.EventSink mEventSink;
    private int mIndex;
    private final Handler mHandler = new Handler(this);
    private Timer mTimer;

    public static void register(Context context, BinaryMessenger messenger) {
        EventChannel channel = new EventChannel(messenger, "samples.flutter.dev/EventChannel");
        channel.setStreamHandler(new DemoEventStreamHandler());
    }

    public DemoEventStreamHandler() {
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        mEventSink = events;
        startTimer();
    }

    @Override
    public void onCancel(Object arguments) {
        mEventSink = null;
        mTimer.cancel();
        mTimer = null;
    }

    void startTimer() {
        mTimer = new Timer();
        mTimer.schedule(new TimerTask() {
                           @Override
                           public void run() {
                               mIndex++;
                               HashMap map = new HashMap();
                               map.put("name", "kai");
                               map.put("age", mIndex);
                               mHandler.sendMessage(mHandler.obtainMessage(1, map));
                           }
                       }
                , 1000, 1000);
    }

    @Override
    public boolean handleMessage(@NonNull Message msg) {
        if (mEventSink != null) {
            mEventSink.success(msg.obj);
        }
        return true;
    }
}
