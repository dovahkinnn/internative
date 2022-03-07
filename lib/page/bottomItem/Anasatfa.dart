// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internative/controller/home_controller.dart';

import '../../controller/favorite_controller.dart';
import '../BlogDetail.dart';

class AnasayfaPage extends StatelessWidget {
  var controller = Get.put(HomeController());
  var fav = Get.put(FavController());

  AnasayfaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Home_category_widget(),
        SizedBox(
          height: 10,
        ),
        Blog_text(),
        SizedBox(
          height: 10,
        ),
        Blog_card(),
      ],
    );
  }

  Blog_text() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Blog",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Home_category_widget() {
    return SizedBox(
      height: 170,
      child: FutureBuilder(
        future: controller.get_category(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.category.value =
                              snapshot.data[index].id.toString();
                          controller.get_blog();
                        },
                        child: SizedBox(
                            height: 100,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data[index].image.toString(),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.data[index].title.toString()),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Blog_card() {
    return Obx(() => Container(
          height: 420,
          child: GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.blog1.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.6,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
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
                                controller.blog1[index].image.toString(),
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
                                  color: fav.favorites.contains(
                                          controller.blog1[index].id.toString())
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 30,
                                )),
                            onPressed: () async {
                              fav.id.value =
                                  controller.blog1[index].id.toString();
                              await fav.add_favorite();
                              await fav.User_info();
                              await fav.getfav_blog();
                              // fav.colot(
                              //     controller.blog1[index].id.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          controller.blog1[index].title.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
              );
            },
          ),
        ));
  }
}
