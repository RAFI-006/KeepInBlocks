import 'dart:convert';

import 'data_list_model.dart';

class GenericResponse {
  String message;
  bool hasError;
  String errorMessage;
  dynamic model;
  int statusCode;

  GenericResponse({
    this.message,
    this.hasError,
    this.errorMessage,
    this.model,
    this.statusCode,
  });

  factory GenericResponse.fromJson(String str) => GenericResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  factory GenericResponse.fromMap(Map<String, dynamic> json) => new GenericResponse(
    message: json["Message"],
    hasError: json["HasError"],
    errorMessage: json["ErrorMessage"],
    model: json["Model"],
    statusCode: json["StatusCode"],
  );

  Map<String, dynamic> toMap() => {
    "Message": message,
    "HasError": hasError,
    "ErrorMessage": errorMessage,
    "Model": model,
    "StatusCode": statusCode,
  };
}

class Response {
  dynamic message;
  bool hasError;
  String errorMessage;
  List<DataListModel> model;
  int statusCode;

  Response({
    this.message,
    this.hasError,
    this.errorMessage,
    this.model,
    this.statusCode,
  });

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => new Response(
    message: json["Message"],
    hasError: json["HasError"],
    errorMessage: json["ErrorMessage"],
    model: new List<DataListModel>.from(json["Model"].map((x) => DataListModel.fromMap(x))),
    statusCode: json["StatusCode"],
  );

  Map<String, dynamic> toMap() => {
    "Message": message,
    "HasError": hasError,
    "ErrorMessage": errorMessage,
    "Model": new List<dynamic>.from(model.map((x) => x.toMap())),
    "StatusCode": statusCode,
  };
}
