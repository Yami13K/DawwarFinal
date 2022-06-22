package com.example.untitled;

import android.content.Context;
import android.net.wifi.WifiManager;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import java.util.concurrent.atomic.AtomicReference;

public class WifiDetector extends Worker {
    public WifiDetector(@NonNull Context context,
                        @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
    }


    @NonNull
    @Override
    public Result doWork() {
        AtomicReference<Boolean> test = new AtomicReference<>(false);
        ContextCompat.getMainExecutor(getApplicationContext()).execute(() -> {
//            Toast.makeText(getApplicationContext(),
//                    "WorkManager Started ...",
//                    Toast.LENGTH_SHORT).show();

            WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(
                    Context.WIFI_SERVICE);
            if (wifiManager.isWifiEnabled()){
                Toast.makeText(getApplicationContext(),
                        "Wifi Enabled",
                        Toast.LENGTH_LONG).show();
                test.set(true);
            }
//            else {
//                Toast.makeText(getApplicationContext(),
//                        "Wifi Disabled",
//                        Toast.LENGTH_LONG).show();
//            }
        });
        if(test.get().booleanValue()) {
            return Result.success();
        }
        else{
            return Result.success();
        }
    }
}