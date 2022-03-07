// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'login_controller.dart';

class ProfileController extends GetxController {
  var token = Get.put(LoginController());
  var location = Location();
  var file = "".obs;
  var url = "".obs;
  var Longtitude = "".obs;
  var Latitude = "".obs;

  save() async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.post(
        "http://test20.internative.net/Account/Update",
        // ignore: unnecessary_brace_in_string_interps
        data:
            // ignore: unnecessary_brace_in_string_interps
            "{\"Image\":\"${file}\",\"Location\":{\"Longtitude\":\"${Longtitude}\",\"Latitude\":\"${Latitude}\"}}");
    if (response.data["HasError"] == false) {
      Get.snackbar('Hi', response.data["Message"],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  LocationData() async {
    var locationData = await location.getLocation();
    Latitude.value = locationData.latitude.toString();
    Longtitude.value = locationData.longitude.toString();
    return locationData;
  }

  post() async {
    String fileName = file.split('/').last;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.value, filename: fileName),
    });

    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${token.token.value}";
    var response = await dio.post(
        "http://test20.internative.net/General/UploadImage",
        data: formData);
    print(response.data);
    if (response.data["HasError"] == false) {
      url.value = response.data["Data"];
    }
  }

  getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      file.value = imageFile.path;
      post();
    }
  }

  getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      file.value = imageFile.path;
      post();
    }
  }

  imageRemovw() {
    file.value = "";
  }

  @override
  void onInit() {
    super.onInit();
    LocationData();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    LocationData();
  }
}
