import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_api_app/scr/Models/peopleModel.dart';
import 'package:http/http.dart' as http;

class PeopleController extends GetxController {
  var firstName = "".obs;
  var lastName = "".obs;
  var age = "".obs;
  var activeDate = "".obs;
  var createdAt = "".obs;
  var updatedAt = "".obs;
  var isLoading = false.obs;
  String url = "https://peopleinfoapi.herokuapp.com/api/person";
  //Get data from API===========================================================
  final peopleData = PeopleModel().obs;
  Future<void> getDate() async {
    isLoading.value = true;
    try {
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        var getResponse = jsonDecode(response.body);
        peopleData.value = PeopleModel.fromJson(getResponse);
        print("seccuss .............!");
      } else if (response.statusCode == 400) {
        print("validate ............!");
      } else if (response.statusCode >= 500) {
        print("server error ........!");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //post to API=================================================================
  Future<void> postDataThatHaveFile() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var headers = {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
      request.fields.addAll({
        "first_name": firstName.value,
        "last_name": lastName.value,
        "age": age.value,
        "active_date": activeDate.value,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        Get.snackbar(
          "Add People",
          "Seccuss .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        Timer(
          Duration(seconds: 2),
          () {
            Timer(
              Duration(seconds: 2),
              () {
                Navigator.pop(Get.context);
              },
            );
          },
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Add People",
          "Something When Wrong .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode >= 500) {
        Get.snackbar(
          "Add People",
          "Server Error .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> postData() async {
    isLoading.value = true;
    try {
      var data = json.encode({
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "active_date": activeDate,
      });
      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
        },
        body: data,
      );
      if (response.statusCode == 201) {
        Get.snackbar(
          "Add People",
          "Seccuss .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        Timer(
          Duration(seconds: 2),
          () {
            Timer(
              Duration(seconds: 2),
              () {
                Navigator.pop(Get.context);
              },
            );
          },
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Add People",
          "Something When Wrong .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode >= 500) {
        Get.snackbar(
          "Add People",
          "Server Error .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //update date to API==========================================================

  Future<void> putData(int id) async {
    isLoading.value = true;
    try {
      var data = jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "active_date": activeDate,
      });
      var response = await http.put(
        "$url/$id",
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json"
        },
        body: data,
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          "Update People",
          "Seccuss .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        Timer(
          Duration(seconds: 2),
          () {
            Timer(
              Duration(seconds: 2),
              () {
                Navigator.pop(Get.context);
              },
            );
          },
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Update People",
          "Something When Wrong .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode >= 500) {
        Get.snackbar(
          "Update People",
          "Server Error .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //delete data from API========================================================
  Future<void> deleteData(int id) async {
    isLoading.value = true;
    try {
      var response = await http.delete("${url}/$id");
      if (response.statusCode == 200) {
        Get.snackbar(
          "Delect",
          "seccuss .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Delect",
          "Something When Wrong .............!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode >= 500) {
        Get.snackbar(
          "Delect",
          "Server error ........!",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
