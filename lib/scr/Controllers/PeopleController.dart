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

//Page..........................
  // var page = 1.obs;
  // Future<void> getListingOfSubmitCases() async {
  //   isloading(true);
  //   try {
  //     var _response = await _httpService.getRequest(
  //         'submit_cases/list_all_case_by_user_login',
  //         queryParameters: {
  //           'page': page.value,
  //           // 'per_page': '20'
  //         },
  //         headers: {
  //           'Authorization':
  //               'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMzRlOTc3NTM4NzAyNDA3ODUxMWI4YWIzZTU5N2QwNjRjYjExYThkZjBiZWI5OGUwNWJiYTU1NDA1ZjM5ZDAxOTU1MTUyYjg2OGFkNzY1NjQiLCJpYXQiOjE2MjA4OTIwNzIuOTM5MDkyLCJuYmYiOjE2MjA4OTIwNzIuOTM5MDk4LCJleHAiOjE2NTI0MjgwNzIuODg3MDQsInN1YiI6IjI0Iiwic2NvcGVzIjpbXX0.xihpsZUoqkH_QPz6oPh-e5Z02dFaXYRkfn4Ir630RMovTKJqrXvfmyVbgc6w3to6btOloWmZypL2HniHAcBEQEZo94UIQG_JxNrq88BviGIf1qKSchfGMit_e-n5YvaOrbcneerkMwrechDybNCkI5zEnz_Q44Xc8E7mEWZyrnAQkU6v9rImOxJJ67W3lOkP4AcyazpsNGBGO-zSfcRCptKuhTSKZTyBJyK7MnUuQ0Cr2F0RnNEHcmpg8-Ao0III32fc9cTGDdOhipeJBrN9veupDas1fA9QVxz2PuuKLL4-dAwEUlJPItgL-sOwW6CpHB7tUwsos0VJa3RTRIj5pe_BILOUT3hoMVDbPL3wxHF-c8ZC_fbV_u4AdNKi3xekPS26nFvyPqXijcSbwZqdQ1agcVpgDU0Ln1L74kofNVOkEF0QH3U_AG61RGMWEk1UzuOM7qGnca3auA2xxThHACetKwBlflzqAbBi3FKyG38FgHVeuIv2jTpNa1KQgZzl-zFIF22U1yhadstjv1Sp17hWUgQVXZn9ARYwwbNLLRFyUCFTHtZba7wSlrVnVp3MxgzSxRuva9yub7QihkkfcfAMspPsyyAu6zE2i9PHE6AG14qZPaEBoVswYxUOBICimjlfDiGTBq0AilFLOnUGkMfkzWGAMprSWnNtnS_Lo4M'
  //         });
  //     if (_response.statusCode == 200) {
  //       //Get data add to Model
  //       submitCase.value = SubmitCase.fromMap(_response.data);
  //       if (page.value <= submitCase.value.meta.lastPage) {
  //         if (page.value == 1) {
  //           //add Data frist page
  //           submitCaseData.value = submitCase.value.data;
  //         } else {
  //           //add Data by page
  //           submitCaseData.addAll(submitCase.value.data);
  //         }
  //         page.value = page.value + 1;
  //       }
  //     } else if (_response.statusCode == 401) {
  //       //UnAuthorization
  //     } else if (_response.statusCode == 404) {
  //       //Page Not Found
  //     }
  //   } catch (e) {
  //     throw Exception("Error In Catch Execption: " + e.message);
  //   } finally {
  //     isloading(false);
  //   }
  // }
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
      var response = await http.delete("$url/$id");
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
