// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, must_be_immutable, sized_box_for_whitespace, file_names, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internative/page/bottomItem/Anasatfa.dart';

import '../controller/favorite_controller.dart';
import '../controller/home_controller.dart';
import 'bottomItem/Profile.dart';
import 'bottomItem/favorite.dart';

class HomePage extends StatelessWidget {
  var landingPageController = Get.put(HomeController(), permanent: false);
  var fav = Get.put(FavController(), permanent: false);
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: Appbar_widget(),
      bottomNavigationBar: buildBottomNavigationMenu(context),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              FavoritePage(),
              AnasayfaPage(),
              ProfilePage(),
            ],
          )),
    ));
  }

  buildBottomNavigationMenu(context) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 65,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            selectedItemColor: Colors.black,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              bottomitemfav(Icons.favorite, "Favorite"),
              bottomitem(Icons.home, "Home"),
              bottomitem(Icons.person, "Profile"),
            ],
          ),
        )));
  }

  bottomitemfav(icon, label) {
    return BottomNavigationBarItem(
      icon: Obx(() => Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Stack(
              children: [
                Icon(icon, size: 30),
                Visibility(
                  visible: fav.viseble.value,
                  child: Positioned(
                    right: 0,
                    child: Container(
                      child: Text(
                        fav.favorites.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
      label: label,
      backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
    );
  }

  bottomitem(icon, label) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(bottom: 7),
        child: Icon(icon, size: 30),
      ),
      label: label,
      backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
    );
  }

  Appbar_widget() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      // ignore: prefer_const_constructors
      title: Obx(() => Text(
            val(),
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }

  val() {
    if (landingPageController.tabIndex.value == 0) {
      return "Favorite";
    } else if (landingPageController.tabIndex.value == 1) {
      return "Home";
    } else {
      return "Profile";
    }
  }
}
