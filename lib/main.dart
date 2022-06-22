

import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/CreatProfile.dart';

import 'package:workmanager/workmanager.dart';

import './screens/map_view.dart';
import './carpBackground/carp_location.dart' as CL;
import 'backgroundTasks/background_fetch.dart';
import 'backgroundTasks/background_wifi.dart';
const String countKey = 'count';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'yamiIsolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

main() async {
  // if (Platform.isAndroid) PathProviderAndroid.registerWith();
  // if (Platform.isIOS) PathProviderIOS.registerWith();
  // Be sure to add this line if initialize() call happens before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
  CL.start();


  await AndroidAlarmManager.oneShot(const Duration(seconds: 10), 999, onWifiAvailable,exact: true,
    wakeup: true,);
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  int i = 0;

  @override
  void initState() {
    super.initState();

    initPlatformState();
    WidgetsBinding.instance?.addObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    setState(() {
      if (AppLifecycleState.detached == state) {

        BackgroundFetch.start();
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
return MaterialApp(
  home: MapView(),
);

}}

  List<List<Object>> c = [["1", 33.33, 22.33, "time"],["1", 33.33, 22.33, "time"]];





