// To parse this JSON data, do
//
//     final mGetTask = mGetTaskFromJson(jsonString);

import 'dart:convert';

MGetTask mGetTaskFromJson(String str) => MGetTask.fromJson(json.decode(str));

String mGetTaskToJson(MGetTask data) => json.encode(data.toJson());

class MGetTask {
  final String? status;
  final String? message;
  final Data? data;

  MGetTask({
    this.status,
    this.message,
    this.data,
  });

  factory MGetTask.fromJson(Map<String, dynamic> json) => MGetTask(
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
  final String title;
  final String description;
  final String creatorEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorEmail,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        creatorEmail: json["creator_email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "creator_email": creatorEmail,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
