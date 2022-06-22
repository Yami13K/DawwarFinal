import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User(
    this.firstName,
    this.lastName,
    this.gender,
    this.profileImage,
    this.ifactive,
    this.personalidImage,
    this.dob,

  );

  String firstName;
  String lastName;
  String gender;
  String profileImage;
  bool ifactive;
  String personalidImage;
  String dob;


  String toRawJson() => json.encode(toJson());


  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "profile_image": profileImage,
    "ifactive": ifactive,
    "personalid_image": personalidImage,
    "dob": dob,
  };
}
