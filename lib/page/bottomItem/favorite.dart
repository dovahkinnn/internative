// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/favorite_controller.dart';
import '../../controller/home_controller.dart';
import '../BlogDetail.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());
  var fav = Get.put(FavController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Obx(() => Column(
              children: [
                Container(
                  height: 620,
                  child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fav.blog2.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Hero(
                        tag: "btn$index",
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    child: InkWell(
                                      onTap: () {
                                        controller.index.value = index;
                                        Get.to(Detail());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          fav.blog2[index].image.toString(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    right: 5,
                                    child: IconButton(
                                      icon: Obx(() => Icon(
                                            Icons.favorite,
                                            color: fav.favorites.contains(fav
                                                    .blog2[index].id
                                                    .toString())
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 30,
                                          )),
                                      onPressed: () {
                                        fav.id.value =
                                            fav.blog2[index].id.toString();
                                        fav.add_favorite();
                                        fav.User_info();
                                        fav.getfav_blog();

                                        // fav.colot(
                                        //     fav.blog2[index].id.toString());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    fav.blog2[index].title.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Color.fromARGB(255, 245, 245, 245),
                                ),
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )));
  }
}
