// To parse this JSON data, do
//
//     final gpsObject = gpsObjectFromMap(jsonString);

import 'dart:convert';
class gps_object{
  const gps_object(double latitude, double longitude,String t)
      :assert(latitude != null),
        assert(longitude != null),
        assert(t !=null),
        id = 'yami',
        latitude =
        (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        longitude = (longitude + 180.0) % 360.0 - 180.0,
        time = t;

  /// The latitude in degrees between -90.0 and 90.0, both inclusive.
  final double latitude;

  /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
  final double longitude;

  final String time;
  final String id;



  Map<String, dynamic> toJson() => {
    "user_id": id == null ? 'yami' : id,
    "lat": latitude == null ? '0': latitude.toStringAsFixed(8),
    "lon": longitude == null ? '0' : longitude.toStringAsFixed(8),
    "time": time == null ? '0' : time,
  };
}
