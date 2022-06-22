// @dart=2.10
import 'dart:async';
//import 'package:carp_background_location/carp_background_location.dart';
import 'package:carp_background_location/carp_background_location.dart';

import 'package:flutter/foundation.dart';
import '../database/funcs.dart';
import 'package:permission_handler/permission_handler.dart';
import '../config/pemissions.dart';

final f = funcs.instance;

LocationDto lastLocation;
DateTime lastTimeLocation;
Stream<LocationDto> locationStream;
StreamSubscription<LocationDto> locationSubscription;

void CarpLocationSettings() {
  LocationManager().interval = 5;
  LocationManager().distanceFilter = 10;
  LocationManager().notificationTitle = 'دوّار';
  LocationManager().notificationMsg = 'دوّار يبحث لك عن رحلات مشتركة';
  LocationManager()..notificationBigMsg=' تطبيق دوّار يتعلم النقلات الخاصة بك ليجد لك اشخاصاً يشاركونك رحلاتك ';
  locationStream = LocationManager().locationStream;
  locationStream = LocationManager().locationStream;
}

String dtoToString(LocationDto dto) =>
    'Location ${dto.latitude}, ${dto.longitude} at ${DateTime.fromMillisecondsSinceEpoch(dto.time ~/ 1)}';

void getCurrentLocation() async =>
    onData(await LocationManager().getCurrentLocation());

void onData(LocationDto dto) {
  // print(dtoToString(dto));
  /* LatLng p = new LatLng(dto.latitude, dto.longitude);
    if (p != null) {
      points.add(p);
    }*/

  if (kDebugMode) {
    print("inside");
  }
  // print(dto);
  // f.insert(dto.latitude, dto.longitude,
  //  '${DateTime.fromMillisecondsSinceEpoch(dto.time ~/ 1)}');

  //print(points);

  lastLocation = dto;
  lastTimeLocation = DateTime.now();
}

/// Start listening to location events.
void start() async {
  //ask();
  if (await askForLocationAlwaysPermission() == true) {
    stop();
    // ask for location permissions, if not already granted

    if (kDebugMode) {
      print('startedddddddddddd');
    }
    CarpLocationSettings();
    locationSubscription?.cancel();
    if (kDebugMode) {
      print('startedddddddddddd');
    }
    locationSubscription = locationStream?.listen(onData);
    await LocationManager().start();
  }
}

void stop() {
  locationSubscription?.cancel();
  LocationManager().stop();
}
