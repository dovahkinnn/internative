// ignore_for_file: non_constant_identifier_names, avoid_print, invalid_use_of_protected_member, prefer_is_empty, unnecessary_brace_in_string_interps, prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/account_model.dart';
import '../models/blogmodel.dart';
import '../models/signmodel.dart';
import 'login_controller.dart';

class FavController extends GetxController {
  var token = Get.put(LoginController());
  var favorites = [].obs;
  var viseble = true.obs;
  var id = "".obs;

  var blog2 = [].obs;

  Dio dio = Dio();

  getfav_blog() async {
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.post("http://test20.internative.net/Blog/GetBlogs",
        data: "{\"CategoryId\":\"\"}");

    final dyn = jsonEncode(response.data);
    var blog = Blog.fromJson(jsonDecode(dyn));
    var bos = [].obs;

    for (var item in blog.data) {
      if (favorites.contains(item.id)) {
        bos.add(item);
      } else {}
    }
    blog2.value = bos;
  }

  add_favorite() async {
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.post(
        "http://test20.internative.net/Blog/ToggleFavorite",
        data: "{\"Id\":\"${id}\"}");

    final dyn = jsonEncode(response.data);
    var blog = Welcome.fromJson(jsonDecode(dyn));
    print(blog.message);
  }

  User_info() async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.get(
      "http://test20.internative.net/Account/Get",
    );

    final dyn = jsonEncode(response.data);
    var account = AccountDetail.fromJson(jsonDecode(dyn));
    print(account.data.favoriteBlogIds);
    favorites.value = account.data.favoriteBlogIds;

    return (account.data);
  }

  @override
  void onInit() {
    super.onInit();
    User_info();
    getfav_blog();
  }

  @override
  void onReady() {
    super.onReady();
    User_info();
    getfav_blog();
  }
}
