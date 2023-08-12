import 'dart:developer';

import 'package:flutter/material.dart';

class TodoModel {
  int id = 0;
  String name;
  String description;
  DateTime? date;
  TimeOfDay? time;
  String color;
  TodoModel({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.date,
    this.color = "",
    this.time,
  });
  factory TodoModel.fromJson(Map<dynamic, dynamic> json) => TodoModel(
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        date: DateTime.tryParse(json["date"]),
        color: json["color"] ?? "",
        time: _getTimeOfDay(json["time"]),
      );
  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "description": description,
        "color": color,
        "date": date?.toIso8601String(),
        "time": "${time?.hour}:${time?.minute}"
      };
}

TimeOfDay? _getTimeOfDay(String? value) {
  if (value == null) return null;
  log("$value  ${TimeOfDay(hour: int.parse(value.split(":").first), minute: int.parse(value.split(":").last))}");
  return TimeOfDay(
      hour: int.parse(value.split(":").first),
      minute: int.parse(value.split(":").last));
}
