package com.example.untitled;

import android.util.Log;


import androidx.work.Constraints;
import androidx.work.NetworkType;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;
import androidx.work.WorkRequest;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    private final String TAG = "i am gay";
    private WorkRequest myWorkRequest;

    @Override
    public void onCreate() {
        super.onCreate();
        WorkManager.getInstance().cancelAllWorkByTag("wifiCheck");
        WorkManager.getInstance().pruneWork();



        Constraints constraints = new Constraints.Builder()
                .setRequiredNetworkType(NetworkType.CONNECTED)
                .build();

        myWorkRequest =
                new OneTimeWorkRequest.Builder(WifiDetector.class)
                        .setConstraints(constraints)
                        .addTag("wifiCheck")
                        .build();

//        uploadWorkRequest = new PeriodicWorkRequest.Builder(UploadWorker.class,
//                15*60*1000, //15 mins is minimum
//                TimeUnit.MILLISECONDS)
//                .build();
    }

    public void daemoner(){
        WorkManager.getInstance().cancelAllWorkByTag("wifiCheck");
        WorkManager.getInstance().pruneWork();
        WorkManager
                .getInstance(this)
                .enqueue(myWorkRequest);

        Log.d(TAG, "Job started");

    }
}

