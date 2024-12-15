// To parse this JSON data, do
//
//     final mUserProfile = mUserProfileFromJson(jsonString);

import 'dart:convert';

MUserProfile mUserProfileFromJson(String str) =>
    MUserProfile.fromJson(json.decode(str));

String mUserProfileToJson(MUserProfile data) => json.encode(data.toJson());

class MUserProfile {
  final String? status;
  final String? message;
  final Data? data;

  MUserProfile({
    this.status,
    this.message,
    this.data,
  });

  factory MUserProfile.fromJson(Map<String, dynamic> json) => MUserProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String image;
  final int activationCode;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.image,
    required this.activationCode,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        image: json["image"],
        activationCode: json["activationCode"],
        isVerified: json["isVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "address": address,
        "image": image,
        "activationCode": activationCode,
        "isVerified": isVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
