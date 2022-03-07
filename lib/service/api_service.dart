// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';

class Service {
  postData_without_auth(url, data) async {
    var response = await Dio().post(
      "http://test20.internative.net/${url}",
      data: data,
    );
    return response;
  }
}
