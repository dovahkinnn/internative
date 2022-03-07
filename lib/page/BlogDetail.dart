// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class Detail extends StatelessWidget {
  Detail({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      controller.blog1[controller.index.value].image.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.grey.shade700),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(
                        controller.blog1[controller.index.value].content,
                        textStyle: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
