package com.example.untitled;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.work.Constraints;
import androidx.work.NetworkType;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkInfo;
import androidx.work.WorkManager;
import androidx.work.WorkRequest;


import java.util.List;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMethodCodec;

import static java.lang.Thread.sleep;

public class MainActivity extends FlutterActivity {
    static final String Reciever_Channel = "yamiDaemoner";
    static boolean tester;


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        BinaryMessenger messenger =
                flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel channel = new MethodChannel(messenger,
                Reciever_Channel);


        ///flutter datum schpatum
        channel.setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("wifi")) {

                        daemoner();
                        result.success(true);
                    }

                }
        );
    }





//        uploadWorkRequest = new PeriodicWorkRequest.Builder(UploadWorker.class,
//                15*60*1000, //15 mins is minimum
//                TimeUnit.MILLISECONDS)
//                .build();


    public void daemoner(){
        WorkManager.getInstance().cancelAllWorkByTag("wifiCheck");
        WorkManager.getInstance().pruneWork();
        Constraints constraints = new Constraints.Builder()
                .setRequiredNetworkType(NetworkType.UNMETERED)
                .build();

        WorkRequest myWorkRequest = new OneTimeWorkRequest.Builder(WifiDetector.class)
                .setConstraints(constraints)
                .addTag("wifiCheck")
                .build();
        myWorkRequest.toString();
        WorkManager
                .getInstance(this)
                .enqueue(myWorkRequest);


        final int[] id = {0};

        LiveData<List<WorkInfo>> wm = WorkManager.getInstance().getWorkInfosByTagLiveData("wifiCheck");

        wm.observe(this, workInfos -> {
            if (workInfos.get(0).getState().isFinished()) {
                id[0]++;
                if (workInfos.isEmpty() || workInfos == null) {
                    Log.d("fuck", "Worker is empty");
                } else {
                    if(id[0] ==1)
                        if (workInfos.get(0).getOutputData().getBoolean("working", true)) {
                            Toast.makeText(getApplicationContext(), "hmmmmmmmmmmmmmmmmmmmmmmm.", Toast.LENGTH_SHORT).show();
                            tester=true;
                        } else {
                                Toast.makeText(getApplicationContext(), "Something went wrong. Try again.", Toast.LENGTH_LONG).show();
                        }

                }
            }});




    }





}

