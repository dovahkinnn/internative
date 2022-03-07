// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.validationErrors,
    required this.hasError,
    required this.message,
    this.data,
  });

  List<dynamic> validationErrors;
  bool hasError;
  String message;
  dynamic data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: json["Data"],
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>.from(validationErrors.map((x) => x)),
        "HasError": hasError,
        "Message": message,
        "Data": data,
      };
}
