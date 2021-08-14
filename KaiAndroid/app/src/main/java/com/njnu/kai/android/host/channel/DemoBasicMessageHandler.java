package com.njnu.kai.android.host.channel;

import android.content.Context;

import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;

/**
 * @author kai
 * @since 2021/8/14
 */
public class DemoBasicMessageHandler implements BasicMessageChannel.MessageHandler {

    public static void register(Context context, BinaryMessenger messenger) {
        BasicMessageChannel msgChannel = new BasicMessageChannel(messenger
                , "samples.flutter.dev/basicMessage", StandardMessageCodec.INSTANCE);
        msgChannel.setMessageHandler(new DemoBasicMessageHandler());

//        msgChannel.send(null, new BasicMessageChannel.Reply() {
//            @Override
//            public void reply(@Nullable Object reply) {
//
//            }
//        });
    }

    @Override
    public void onMessage(@Nullable Object message, @NonNull BasicMessageChannel.Reply reply) {
        Map fromMap = (Map) message;
        String name = (String) fromMap.get("name");
        int age = (int) fromMap.get("age");
        Map toMap = new HashMap();
        toMap.put("name", "hello " + name);
        toMap.put("age", ++age);
        reply.reply(toMap);
    }
}
