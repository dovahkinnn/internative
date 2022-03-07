// ignore: file_names
// ignore_for_file: unused_import, prefer_const_constructors, file_names, duplicate_ignore, avoid_print, unused_field, must_be_immutable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers, unused_element, unnecessary_brace_in_string_interps

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internative/controller/profile_controller.dart';
import 'package:internative/models/googlemapsstyle.dart';
import 'package:internative/page/LoginPage.dart';
import 'package:location/location.dart';

import '../../main.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  var profile_controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        SizedBox(height: 20),
        Center(
          child: Stack(
            // ignore: prefer_const_literals_to_create_immutables
            children: [avatar(), camera_icon()],
          ),
        ),
        SizedBox(height: 20),
        googlemaps(),
        SizedBox(height: 20),
        save_button_widget(),
        SizedBox(height: 20),
        Logout_button_widget(),
      ],
    );
  }

  googlemaps() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170,
        width: 340,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: Offset(0, 5), blurRadius: 10)
            ]),
        child: FutureBuilder(
          future: profile_controller.LocationData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return GoogleMap(
                circles: {
                  Circle(
                    circleId: CircleId("1"),
                    center:
                        LatLng(snapshot.data.latitude, snapshot.data.longitude),
                    radius: 40,
                    fillColor: Colors.blue,
                    strokeColor: Colors.blue,
                    strokeWidth: 2,
                  )
                },
                onMapCreated: (GoogleMapController controller) {
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              snapshot.data.latitude, snapshot.data.longitude),
                          zoom: 15)));
                  controller.setMapStyle(googlemapp().mapstyle);
                },
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data.latitude, snapshot.data.longitude),
                  zoom: 5,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  camera_icon() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: IconButton(
          onPressed: () {
            Get.bottomSheet(
                Obx(() => Container(
                      height: 600,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.blue,
                              height: 300,
                              width: 300,
                              child: ClipRRect(
                                child: Image.file(
                                  File(profile_controller.file.value),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              modal_select_buttton(),
                              SizedBox(width: 20),
                              modal_remove_widget()
                            ],
                          )
                        ],
                      ),
                    )),
                backgroundColor: Colors.white);
            // getFromGallery();
          },
          icon: Icon(
            Icons.camera_alt,
            size: 60,
          )),
    );
  }

  modal_remove_widget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: 180,
      height: 60,
      child: InkWell(
        onTap: () {
          profile_controller.imageRemovw();
        },
        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Text(
              "Remove",
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

  modal_select_buttton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      width: 180,
      height: 60,
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
              content: Column(
            children: [
              ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    profile_controller.getFromCamera();
                  },
                  label: Text("camera"),
                  style: ElevatedButton.styleFrom(primary: Colors.black)),
              SizedBox(width: 20),
              ElevatedButton.icon(
                  icon: Icon(Icons.photo_library, color: Colors.black),
                  onPressed: () {
                    profile_controller.getFromGallery();
                  },
                  label: Text(
                    "gallery",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white)),
            ],
          ));
        },
        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              "Select",
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

  avatar() {
    return Obx(() => CircleAvatar(
          radius: 90,
          backgroundImage: FileImage(
            File(profile_controller.file.value),
          ),
        ));
  }

  save_button_widget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: 340,
      height: 60,
      child: InkWell(
        onTap: () {
          profile_controller.save();
        },
        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 130.0),
            child: Text(
              "Save",
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

  Logout_button_widget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      width: 340,
      height: 60,
      child: InkWell(
        onTap: () {
          GetStorage box = GetStorage();
          box.erase();
          Get.to(LoginPage());
        },

        // ignore: prefer_const_literals_to_create_immutables
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 120.0),
            child: Text(
              "Log Out",
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
}
