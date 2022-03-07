// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    required this.validationErrors,
    required this.hasError,
    required this.message,
    required this.data,
  });

  List<dynamic> validationErrors;
  bool hasError;
  dynamic message;
  List<Datum> data;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
    required this.content,
    required this.image,
    required this.categoryId,
    required this.id,
  });

  String title;
  String content;
  String image;
  String categoryId;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["Title"],
        content: json["Content"],
        image: json["Image"],
        categoryId: json["CategoryId"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Content": content,
        "Image": image,
        "CategoryId": categoryId,
        "Id": id,
      };
}
