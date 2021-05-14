import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_api_app/scr/Controllers/PeopleController.dart';
import 'package:learn_api_app/scr/Screens/addScreen.dart';
import 'package:learn_api_app/scr/Widgets/showCard.dart';

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final peopleController = Get.put(PeopleController());
  @override
  void initState() {
    super.initState();
    peopleController.getDate();
  }

  onRefresh() {
    peopleController.peopleData.value.peopleList.clear();
    peopleController.getDate();
    // return re.currentState.getCountryData();
    return 'success';
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddScreen(
                            status: "add",
                          ),
                        )).then((Value) {
                      onRefresh();
                    });
                  },
                  child: Icon(Icons.add))
            ],
            title: Text("Informations"),
          ),
          body: peopleController.isLoading.value == true
              ? Center(child: CircularProgressIndicator())
              : Obx(
                  () => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    key: refreshKey,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      child: peopleController.peopleData.value.peopleList !=
                              null
                          ? SingleChildScrollView(
                              child: Column(
                                children: peopleController
                                    .peopleData.value.peopleList
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            peopleController.firstName.value =
                                                e.firstName;
                                            peopleController.lastName.value =
                                                e.lastName;
                                            peopleController.age.value = e.age;
                                            peopleController.activeDate.value =
                                                e.activeDate;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScreen(
                                                    status: "update",
                                                    caseID: e.id,
                                                  ),
                                                )).then((value) {
                                              onRefresh();
                                            });
                                          },
                                          child: ShowCard(
                                            firstName: e.firstName,
                                            lastName: e.lastName,
                                            activeDate: e.activeDate,
                                            age: e.age,
                                            createdAt: e.createdAt,
                                            updatedAt: e.updatedAt,
                                            onTeb: () {
                                              peopleController.deleteData(e.id);
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                )),
    );
  }
}
