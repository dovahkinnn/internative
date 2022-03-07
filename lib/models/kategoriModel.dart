// To parse this JSON data, do
//
//     final welcomear1 = welcomear1FromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Welcomear1 welcomear1FromJson(String str) =>
    Welcomear1.fromJson(json.decode(str));

String welcomear1ToJson(Welcomear1 data) => json.encode(data.toJson());

class Welcomear1 {
  Welcomear1({
    required this.validationErrors,
    required this.hasError,
    this.message,
    required this.data,
  });

  List<dynamic> validationErrors;
  bool hasError;
  dynamic message;
  List<Datum> data;

  factory Welcomear1.fromJson(Map<String, dynamic> json) => Welcomear1(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>.from(validationErrors.map((x) => x)),
        "HasError": hasError,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.image,
    required this.id,
  });

  String title;
  String image;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["Title"],
        image: json["Image"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Image": image,
        "Id": id,
      };
}
