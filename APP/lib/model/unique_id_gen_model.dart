// To parse this JSON data, do
//
//     final uniqueIdGenModel = uniqueIdGenModelFromJson(jsonString);

import 'dart:convert';

class UniqueIdGenModel {
  int id;
  String uniqueId;
  String contractAdd;

  UniqueIdGenModel({
    this.id,
    this.uniqueId,
    this.contractAdd,
  });

  factory UniqueIdGenModel.fromJson(String str) => UniqueIdGenModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UniqueIdGenModel.fromMap(Map<String, dynamic> json) => new UniqueIdGenModel(
    id: json["id"],
    uniqueId: json["uniqueId"],
    contractAdd: json["contractAdd"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "uniqueId": uniqueId,
    "contractAdd": contractAdd,
  };
}
