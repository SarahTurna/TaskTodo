// To parse this JSON data, do
//
//     final mAuthLogin = mAuthLoginFromJson(jsonString);

import 'dart:convert';

MAuthLogin mAuthLoginFromJson(String str) =>
    MAuthLogin.fromJson(json.decode(str));

String mAuthLoginToJson(MAuthLogin data) => json.encode(data.toJson());

class MAuthLogin {
  String? status;
  String? message;
  Data? data;

  MAuthLogin({
    this.status,
    this.message,
    this.data,
  });

  factory MAuthLogin.fromJson(Map<String, dynamic> json) => MAuthLogin(
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
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String address;
  String image;
  int activationCode;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.image,
    required this.activationCode,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
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
        "address": address,
        "image": image,
        "activationCode": activationCode,
        "isVerified": isVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
