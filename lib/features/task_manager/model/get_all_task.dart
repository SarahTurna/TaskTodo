// To parse this JSON data, do
//
//     final mGetAllTask = mGetAllTaskFromJson(jsonString);

import 'dart:convert';

MGetAllTask mGetAllTaskFromJson(String str) =>
    MGetAllTask.fromJson(json.decode(str));

String mGetAllTaskToJson(MGetAllTask data) => json.encode(data.toJson());

class MGetAllTask {
  final String status;
  final String message;
  final Data data;

  MGetAllTask({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MGetAllTask.fromJson(Map<String, dynamic> json) => MGetAllTask(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final int count;
  final List<MyTask> myTasks;

  Data({
    required this.count,
    required this.myTasks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        myTasks:
            List<MyTask>.from(json["myTasks"].map((x) => MyTask.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "myTasks": List<dynamic>.from(myTasks.map((x) => x.toJson())),
      };
}

class MyTask {
  final String id;
  final String title;
  final String description;
  final String creatorEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorEmail,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MyTask.fromJson(Map<String, dynamic> json) => MyTask(
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
