package com.njnu.kai.android.host;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;

import java.util.HashMap;
import java.util.Locale;

public class SecondTestActivity extends AppCompatActivity implements View.OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second_test);
        final Intent intent = getIntent();
        String title1 = intent.getStringExtra("title");
//        String title2 = savedInstanceState.getString("title");
        TextView textView = findViewById(R.id.tv_text);
        textView.setText(String.format(Locale.getDefault(), "t=%s %d %.2f %s", title1
                , intent.getLongExtra("keyInt", 0), intent.getDoubleExtra("keyFloat", 0)
                , intent.getStringExtra("keyMap")));
        findViewById(R.id.btn_test_start_flutter).setOnClickListener(this);
        findViewById(R.id.btn_return_data).setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        final int viewId = v.getId();
        if (viewId == R.id.btn_test_start_flutter) {
            final HashMap<String, Object> arguments = new HashMap<>();
            arguments.put("title", "Counter From Native");
            arguments.put("customKey", 888);
            FlutterBoostRouteOptions options = new FlutterBoostRouteOptions.Builder()
                    .pageName("/provider_counter_page").arguments(arguments).build();
            FlutterBoost.instance().open(options);
        } else if (viewId == R.id.btn_return_data) {
            final Intent intent = new Intent();
            intent.putExtra("keyString", "FromNativeString");
            intent.putExtra("keyInt", 1234);
            setResult(RESULT_OK, intent);
            finish();
        }
    }
}