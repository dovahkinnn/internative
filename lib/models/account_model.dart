// To parse this JSON data, do
//
//     final accountDetail = accountDetailFromJson(jsonString);

import 'dart:convert';

AccountDetail accountDetailFromJson(String str) =>
    AccountDetail.fromJson(json.decode(str));

String accountDetailToJson(AccountDetail data) => json.encode(data.toJson());

class AccountDetail {
  AccountDetail({
    required this.validationErrors,
    required this.hasError,
    required this.message,
    required this.data,
  });

  List<dynamic> validationErrors;
  bool hasError;
  dynamic message;
  Data data;

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>.from(validationErrors.map((x) => x)),
        "HasError": hasError,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.image,
    required this.location,
    required this.favoriteBlogIds,
  });

  String id;
  String email;
  dynamic image;
  dynamic location;
  List<String> favoriteBlogIds;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"],
        email: json["Email"],
        image: json["Image"],
        location: json["Location"],
        favoriteBlogIds:
            List<String>.from(json["FavoriteBlogIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "Image": image,
        "Location": location,
        "FavoriteBlogIds": List<dynamic>.from(favoriteBlogIds.map((x) => x)),
      };
}
