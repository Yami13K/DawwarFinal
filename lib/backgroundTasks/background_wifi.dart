
import 'dart:convert';
import 'dart:io';

import 'package:untitled/screens/map_view.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_fetch/background_fetch.dart' hide NetworkType;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/apis/wifi_api.dart';
import 'package:workmanager/workmanager.dart';
import '../carpBackground/carp_location.dart' as CL;
import '../database/funcs.dart';
import '../models/gps_object.dart';
import 'background_fetch.dart';

final f = funcs.instance;
class Data {
  int i=0;
  static bool paused = false;
}
Data id = Data();


bool hasInternet = false;
ConnectivityResult result = ConnectivityResult.none;
void backgroundFetchHeadlessTask( HeadlessTask task) async {
  var taskId = task.taskId;
  var timeout = task.timeout;
  if (timeout) {
    if (kDebugMode) {
      print("[BackgroundFetch] Headless task timed-out: $taskId");
    }
    BackgroundFetch.finish(taskId);
    return;
  }

  if (kDebugMode) {
    print("[BackgroundFetch] Headless event received: $taskId");
  }

  var timestamp = DateTime.now();

  var prefs = await SharedPreferences.getInstance();
  if (taskId == "com.dawwar.yami") {
    CL.stop();
    CL.start();
  }
  var events = <String>[];
  var json = prefs.getString(EVENTS_KEY);
  if (json != null) {
    events = jsonDecode(json).cast<String>();
  }
  events.insert(0, "$taskId@$timestamp [Headless]");
  prefs.setString(EVENTS_KEY, jsonEncode(events));


  if (taskId == 'flutter_background_fetch') {
    CL.start();
    print('l');
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.dawwar.yami",
        delay: 69420,
        periodic: false,
        forceAlarmManager: false,
        stopOnTerminate: false,
        enableHeadless: true
    ));
  }
  BackgroundFetch.finish(taskId);
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if(id.i>0)
      getReciever();
    if (task == wifi_task ) {
      print("Native called background task: BackGround_location "); //simpleTask will be emitted here.

    }
    else{

      print('native');
    }
    return Future.value(true);
  });
}

const wifi_task = 'wificheck';

  void reee() {
    if(id.i==2) {
      print('weeeze');
      getReciever();
    }
  }
 Future<void> getReciever()async {
  if(Platform.isAndroid) {
      var recieverChannel = const MethodChannel('yamiDaemoner');
      await recieverChannel.invokeMethod('wifi');


  }
}
// void periodic_init(){
//   Workmanager().registerPeriodicTask(
//     "period",
//     "period", // Ignored on iOS
//     constraints: Constraints(
//       // connected or metered mark the task as requiring internet
//       networkType: NetworkType.connected,
//       // require external power
//     ),
//     frequency: const Duration(minutes: 20),
//     existingWorkPolicy: ExistingWorkPolicy.append,
//   );}
//
// void initialize(){
//   Workmanager().initialize(
//       callbackDispatcher, // The top level function, aka callbackDispatcher
//       isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
//   );
//   Workmanager().cancelByTag(wifi_task);
//   Workmanager().registerOneOffTask(
//     wifi_task,
//     wifi_task, // Ignored on iOS
//     constraints: Constraints(
//       networkType: NetworkType.connected,
//     ),
//
//   );
//
//   }


Future<void> onWifiAvailable() async {
  await AndroidAlarmManager.cancel(999);

  Connectivity().onConnectivityChanged.listen((reesult) {
    result = reesult;
  });

  InternetConnectionChecker().onStatusChange.listen((status) {
    hasInternet = status == InternetConnectionStatus.connected;
  });
  if (result == ConnectivityResult.wifi) {
    if (!Data.paused) {
      var loc = await f.get_lasel();
      print(loc.toString());
      var userLoc = LatLng(loc.latitude, loc.longitude); // User Location
      var geofenceCenter = LatLng(33.5187981, 36.2861145);
      var distanceInMeters = SphericalUtil.computeDistanceBetween(
          userLoc, geofenceCenter);
      if (distanceInMeters < 50) {
        CL.stop();
        Data.paused = true;

        print(distanceInMeters.toString() + 'i am satisfied');
      }
      else
        print(distanceInMeters.toString() + ' so far');
    }
    id.i = 0;
  }
  else {
    id.i++;
    // reee();
    print(id.i);
    if (Data.paused) {
      CL.start();
      Data.paused = false;
    }
    print(' هيي هيي عليينا');
    print(Data.paused.toString());
  }
  print('fml');
  print(result);
  print(hasInternet);
  List<dynamic> unpack = [];
  List<dynamic> check = [];
  List<gps_object> c = [];
  List ids = [];
  bool sent = false;

  if (result == ConnectivityResult.wifi && hasInternet) {
    unpack = await f.data_store(100);
    print(unpack);
    if (unpack != null) {
      c = unpack.first;
      ids = unpack.last;
      sent = await send_points(c);
      print(sent);
      if (sent) {
        await f.delete_list(ids);
      }
      else {
        print('ابيييييتش');
      }
      check = await f.data_store(2);
      if (check.first.length > 1) {

      }
    }

  }
  await AndroidAlarmManager.oneShot(
      const Duration(seconds: 10), 999, onWifiAvailable, exact: true,
      wakeup: true);
}