
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'database_helper.dart';

import '../models/gps_object.dart';
class funcs {
  funcs._privateConstructor();
  static final funcs instance = funcs._privateConstructor();

  final dbHelper = DatabaseHelper.instance;

  void insert(lat, long, time) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnLat: lat,
      DatabaseHelper.columnLong: long,
      DatabaseHelper.columnTime:time,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    print(time);
  }

  void delete_list(List list)   {

    list.forEach((l) async => await dbHelper.delete(l));

  }
  Future<LatLng> get_lasel()async{
    final n = await dbHelper.queryRowCount();
    var row = await dbHelper.queryNRows(n);
    var lasel;
    for (var r in row) {
      lasel = LatLng(r['lat'], r['long']);
    }
    return lasel;
  }
  Future<List<dynamic>> data_store(n) async {
    List<gps_object> result = [];
    List ids = [];

    final Nrows = await dbHelper.queryNRows(n);
      for (var row in Nrows) {

        result.add(gps_object(row['lat'], row['long'], row['time']));
        ids.add(row['_id']);
      }
      return [result, ids];


  }
  Future<List<LatLng>> query() async {
    List<LatLng> result = [];

    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    //allRows.forEach(print);
    for (var row in allRows ){
      //print(row['lat'].runtimeType);
      //print(row['long'].runtimeType);
      
      result.add(LatLng(row['lat'], row['long']));
    }

    return result;
  }


}
