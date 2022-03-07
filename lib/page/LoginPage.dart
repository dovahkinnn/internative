// ignore_for_file: non_constant_identifier_names, must_be_immutable, file_names, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import 'SignupPage.dart';

class LoginPage extends StatelessWidget {
  var controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: Appbar_widget(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                sizedbox(30.0),
                box_widget(),
                sizedbox(20.0),
                email_form_widget(),
                password_form_widget(),
                sizedbox(30.0),
                login_button_widget(),
                sizedbox(30.0),
                register_button_widget(),
              ],
            ),
          ),
        ));
  }

  email_form_widget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller.emailcontrol,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          labelText: 'Email',
          hintText: 'Enter your email',
          prefixIcon: Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  password_form_widget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller.passwordcontrol,
        onTap: () {
          controller.isVisible.value = false;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            labelText: 'Password',
            hintText: "Enter your password",
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(controller.isHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                controller.isHidden.value = !controller.isHidden.value;
              },
            )),
        obscureText: controller.isHidden.value,
      ),
    );
  }

  sizedbox(height) {
    return SizedBox(
      height: height,
    );
  }

  box_widget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: Colors.grey),
        height: 150,
        width: 150,
      ),
    );
  }

  Appbar_widget() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      // ignore: prefer_const_constructors
      title: Text(
        "Login",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  login_button_widget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      width: 280,
      height: 45,
      child: InkWell(
        onTap: () {
          controller.user_login(controller.emailcontrol.text.trim(),
              controller.passwordcontrol.text.trim());
        },
        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.login,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 120.0),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  register_button_widget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: 280,
      height: 45,
      child: InkWell(
        onTap: () {
          Get.to(SignupPage());
        },
        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.login,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 120.0),
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
