// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internative/page/HomePage.dart';

class LoginController extends GetxController {
  var isVisible = false.obs;
  var isHidden = true.obs;
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();
  var email1 = "".obs;
  var token = "".obs;
  GetStorage box2 = GetStorage();
  changeVisibility() {
    isHidden.value = !isHidden.value;
  }

  user_login(email, password) async {
    try {
      var response = await Dio().post(
        "http://test20.internative.net/Login/SignIn",
        // ignore: unnecessary_brace_in_string_interps
        data:
            // ignore: unnecessary_brace_in_string_interps
            "{\"Email\":\"${email}\",\"Password\":\"${password}\"}",
      );
      print(response.data);
      if (response.data['HasError'] == false) {
        token.value = response.data["Data"]['Token'];
        await box2.write("token", token.value);
        print(box2.read("token"));

        email1.value = email;
        print(token);
        await clerar();
        Get.offAll(HomePage());

        Get.snackbar(
          "Başarıyla Giriş Yapıldı",
          "Hoşgeldiniz",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      } else if (response.data["Message"] ==
          "Lütfen hatalı alanları kontrol edin.") {
        Get.snackbar(
          "Error",
          response.data['ValidationErrors'][0]["Value"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          response.data['Message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  clerar() {
    emailcontrol.clear();
    passwordcontrol.clear();
  }

  aa() {
    var atoken = box2.read("token");
    if (atoken != null) {
      token.value == "";
    } else {
      token.value = atoken.toString();
    }
  }

  @override
  void onInit() {
    super.onInit();
    aa();
  }
}
