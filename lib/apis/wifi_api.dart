import 'dart:convert';


import 'package:http/http.dart' as http;

import '../models/gps_object.dart';






Future<bool> send_points(List<gps_object> object) async {
  String uploadurl = "http://192.168.1.8:8000/rest/fbv/";
  String gg= '';

  var j = jsonEncode(object.map((i) => i.toJson()).toList()).toString();
  print(j);

  try {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.post(Uri.parse(uploadurl), body: j,headers: headers);
    gg = response.body.toString();
    if (response.statusCode.toInt() == 201) {
      return true;
    } else {
      return false;

    }
  }
  catch (e){
    return false;

  }


}

