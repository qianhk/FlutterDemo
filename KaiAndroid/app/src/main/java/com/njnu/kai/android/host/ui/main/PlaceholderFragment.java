package com.njnu.kai.android.host.ui.main;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.njnu.kai.android.host.R;
import com.njnu.kai.testc.NdkJniTest;

import java.util.HashMap;
import java.util.Locale;

/**
 * A placeholder fragment containing a simple view.
 */
public class PlaceholderFragment extends Fragment implements View.OnClickListener {

    private static final String ARG_SECTION_NUMBER = "section_number";

    private PageViewModel pageViewModel;

    public static PlaceholderFragment newInstance(int index) {
        PlaceholderFragment fragment = new PlaceholderFragment();
        Bundle bundle = new Bundle();
        bundle.putInt(ARG_SECTION_NUMBER, index);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        pageViewModel = new ViewModelProvider(this).get(PageViewModel.class);
        int index = 1;
        if (getArguments() != null) {
            index = getArguments().getInt(ARG_SECTION_NUMBER);
        }
        pageViewModel.setIndex(index);
    }

    @Override
    public View onCreateView(
            @NonNull LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
        View root = inflater.inflate(R.layout.fragment_main, container, false);
        final TextView textView = root.findViewById(R.id.section_label);
        pageViewModel.getText().observe(this, new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        root.findViewById(R.id.btn_flutter).setOnClickListener(this);
        root.findViewById(R.id.btn_jni_string).setOnClickListener(this);
        root.findViewById(R.id.btn_jni_sum).setOnClickListener(this);
        root.findViewById(R.id.btn_crash_it).setOnClickListener(this);
        return root;
    }

    @Override
    public void onClick(View v) {
        final int viewId = v.getId();
        if (viewId == R.id.btn_jni_string) {
            final String tmpStr = NdkJniTest.stringFromJNI();
            Toast.makeText(getContext(), tmpStr, Toast.LENGTH_SHORT).show();
        } else if (viewId == R.id.btn_jni_sum) {
            int a = 3, b = 4;
            int sum = NdkJniTest.sum(a, b);
            Toast.makeText(getContext(), String.format(Locale.getDefault(), "%d + %d = %d", a, b, sum)
                    , Toast.LENGTH_SHORT).show();
        } else if (viewId == R.id.btn_crash_it) {
//            String tmpStr = null;
//            tmpStr.length();
            NdkJniTest.testCrashInNative(true);
        } else if (viewId == R.id.btn_flutter) {
            FlutterBoostRouteOptions options = new FlutterBoostRouteOptions.Builder()
                    .pageName("/test_page_1").arguments(new HashMap<>()).requestCode(1111).build();
            FlutterBoost.instance().open(options);
        }
    }
}