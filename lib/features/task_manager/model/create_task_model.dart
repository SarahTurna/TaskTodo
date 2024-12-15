// To parse this JSON data, do
//
//     final mCreateTask = mCreateTaskFromJson(jsonString);

import 'dart:convert';

MCreateTask mCreateTaskFromJson(String str) =>
    MCreateTask.fromJson(json.decode(str));

String mCreateTaskToJson(MCreateTask data) => json.encode(data.toJson());

class MCreateTask {
  final String? status;
  final String? message;
  final Data? data;

  MCreateTask({
    this.status,
    this.message,
    this.data,
  });

  factory MCreateTask.fromJson(Map<String, dynamic> json) => MCreateTask(
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
  final String title;
  final String description;
  final String creatorEmail;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Data({
    required this.title,
    required this.description,
    required this.creatorEmail,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
        creatorEmail: json["creator_email"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "creator_email": creatorEmail,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
