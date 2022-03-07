// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internative/page/LoginPage.dart';

class SignupController extends GetxController {
  var isVisible = false.obs;
  var isHidden = true.obs;

  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();
  var re_passwordcontrol = TextEditingController();
  changeVisibility() {
    isHidden.value = !isHidden.value;
  }

  user_signup(email, password, repassword) async {
    try {
      var response = await Dio().post(
        "http://test20.internative.net/Login/SignUp",
        // ignore: unnecessary_brace_in_string_interps
        data:
            // ignore: unnecessary_brace_in_string_interps
            "{\"Email\":\"${email}\",\"Password\":\"${password}\",\"PasswordRetry\":\"${repassword}\"}",
      );
      print(response.data);
      if (response.data['HasError'] == false) {
        clerar();
        Get.offAll(LoginPage());

        Get.snackbar(
          "Başarıyla Kayıt Oldunuz",
          "Login Sayfasına Giderek Giriş Yapınız",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
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
    re_passwordcontrol.clear();
  }
}
