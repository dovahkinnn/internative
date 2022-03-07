// ignore_for_file: unnecessary_overrides, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_single_cascade_in_expression_statements, invalid_use_of_protected_member

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internative/controller/login_controller.dart';

import '../models/blogmodel.dart';
import '../models/kategoriModel.dart';

class HomeController extends GetxController {
  var token = Get.put(LoginController());
  var blog1 = [].obs;
  var category = "".obs;
  var index = 0.obs;

  var tabIndex = 0.obs;
  var counter = 0.obs;

  Dio dio = Dio();

  get_category() async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.get(
      "http://test20.internative.net/Blog/GetCategories",
    );

    final dyn = jsonEncode(response.data);
    var categori = Welcomear1.fromJson(jsonDecode(dyn));

    return (categori.data);
  }

  get_blog() async {
    dio.options.headers["Authorization"] =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI2MjIyOWRkNmIwN2QxZTEzOWFmNWI1MGIiLCJuYmYiOjE2NDY0MzU3OTgsImV4cCI6MTY0OTAyNzc5OCwiaXNzIjoiaSIsImF1ZCI6ImEifQ.GQxqfda3N1DCRpufN4rrkFcPA9ti2fEVVh0th_FxHlU";
    var response = await dio.post("http://test20.internative.net/Blog/GetBlogs",
        data: "{\"CategoryId\":\"${category}\"}");

    final dyn = jsonEncode(response.data);
    var blog = Blog.fromJson(jsonDecode(dyn));
    blog1.value = blog.data;

    return blog1.value;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    get_blog();
  }

  @override
  void onReady() {
    super.onReady();
    get_blog();
  }
}
