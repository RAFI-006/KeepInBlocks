// To parse this JSON data, do
//
//     final dataListModel = dataListModelFromJson(jsonString);

import 'dart:convert';

class DataListModel {
  int id;
  String heading;
  String note;

  DataListModel({
    this.id,
    this.heading,
    this.note,
  });

  factory DataListModel.fromJson(String str) => DataListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataListModel.fromMap(Map<String, dynamic> json) => new DataListModel(
    id: json["Id"],
    heading: json["Heading"],
    note: json["Note"],
  );

  Map<String, dynamic> toMap() => {
    "Id": id,
    "Heading": heading,
    "Note": note,
  };
}
