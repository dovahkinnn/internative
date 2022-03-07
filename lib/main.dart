// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, unused_import, prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internative/page/LoginPage.dart';

import 'controller/login_controller.dart';
import 'page/HomePage.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var token = Get.put(LoginController());
  home() {
    var atoken = GetStorage().read("token");
    if (atoken != null) {
      token.token.value = atoken.toString();
      return atoken.toString();
    } else {
      print(atoken);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: (home() == null) ? LoginPage() : HomePage(),
    );
  }
}
