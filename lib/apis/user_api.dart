import 'dart:convert';


import 'package:http/http.dart' as http;
import '../models/user.dart';



Future<bool> send_user(User user) async {
  try {
    final uri = Uri.parse("http://192.168.1.8:8000/api/rest/register_List/");

    final request = http.MultipartRequest('POST', uri);

    request.fields['first_name'] = user.firstName;
    request.fields['last_name'] = user.lastName;
    request.fields['gender'] = user.gender;
    request.fields['ifactive'] = false.toString();
    request.fields['dob'] = user.dob.toString();



    final multipartFile =
    await http.MultipartFile.fromPath(
        'profile_image',user.profileImage ); // Image is the parameter name
  final multipartFile1 =
  await http.MultipartFile.fromPath(
  'personalid_image',user.personalidImage );
  request.files.add(multipartFile);
  request.files.add(multipartFile1);
  print(multipartFile.filename);
  print(multipartFile1.filename);

    print(request.fields);
    final response = await request.send();
    if (response.statusCode == 201) {
      print('success');
    } else {

      print('Something went wrong' + response.statusCode.toString());
    }
  } catch (e) {
    print('Something went wrong' + e.toString());
  }
}