import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../backgroundTasks/background_wifi.dart';
import '../database/funcs.dart';

import '../main.dart';

final f = funcs.instance;

class lCircle {
  static Set<Circle> circles ={};
}
class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Set<Polyline> polyline = {};
  List<LatLng> dpoints = [];
  GoogleMapController _controller;
  static const LatLng _center = LatLng(33.5255936, 36.2771937);



  Future<void> draw() async {
    await AndroidAlarmManager.oneShot(
        const Duration(seconds: 10), 999, onWifiAvailable, exact: true,
        wakeup: true);
    getReciever();
    dpoints = await f.query();
    print('done');
    setState(() {
      polyline.clear();
      polyline.add(Polyline(
          polylineId: PolylineId('Droute'),
          points: dpoints,
          visible: true,
          color: Colors.purple,
          width: 2));


    });

  }

Future<void> add() async {
  var loc = await f.get_lasel();

  lCircle.circles.add(Circle(
    circleId: CircleId('2'),
    center: LatLng(loc.latitude,loc.longitude),
    radius: 50,
    strokeColor: Colors.transparent,
    strokeWidth: 0,
    fillColor: Color(0x806394EC),

  ));
  lCircle.circles.add(Circle(
    circleId: CircleId('1'),
    center: LatLng(33.523486,36.2724172),
    radius: 50,
    strokeColor: Colors.transparent,
    strokeWidth: 0,
    fillColor: Color(0x806394EC),
  ));
}



  void getFirst() async {
    LocationDto first = await LocationManager().getCurrentLocation();
    setState(() {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(first.latitude, first.longitude),
        zoom: 18.0,
      )));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    print('createddddddddddd');
    _controller = controller;
    //start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            polylines: polyline,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 11.0,
            ),circles: lCircle.circles

          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                      onPressed: draw,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: Text("Draw")))),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      onPressed: add,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: Text("add SP"))))
        ]));
  }
}
