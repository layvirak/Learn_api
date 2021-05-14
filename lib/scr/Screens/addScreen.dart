import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_api_app/scr/Controllers/PeopleController.dart';

class AddScreen extends StatelessWidget {
  String status;
  int caseID;
  AddScreen({this.status, this.caseID});
  final peopleController = Get.put(PeopleController());
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: status == "add"
            ? Text("Add People Information")
            : Text("Update People Information"),
      ),
      body: Obx(
        () => peopleController.isLoading.value == false
            ? Form(
                key: _key,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          initialValue: status == "update"
                              ? peopleController.firstName.value
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal)),
                              labelText: "First Name *",
                              hintText: "Enter Your First Name"),
                          onSaved: (String value) {
                            peopleController.firstName.value = value;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          initialValue: status == "update"
                              ? peopleController.lastName.value
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal)),
                              labelText: "Last Name *",
                              hintText: "Enter Your Last Name"),
                          onSaved: (String value) {
                            peopleController.lastName.value = value;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          initialValue: status == "update"
                              ? peopleController.age.value
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal)),
                              labelText: "Age *",
                              hintText: "Enter Your  Age"),
                          onSaved: (String value) {
                            peopleController.age.value = value;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          initialValue: status == "update"
                              ? peopleController.activeDate.value
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal)),
                              labelText: "Active",
                              hintText: "Enter Your Active"),
                          onSaved: (String value) {
                            peopleController.activeDate.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Back"),
                color: Colors.grey,
                onPressed: peopleController.isLoading.value == false
                    ? () {
                        _key.currentState.save();
                        status == "add"
                            ? peopleController.postData()
                            : peopleController.putData(caseID);
                      }
                    : null,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(right: 20, bottom: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(status == "add" ? "Submit" : "Update"),
                color: Colors.blue,
                onPressed: peopleController.isLoading.value == false
                    ? () {
                        print(caseID);
                        _key.currentState.save();
                        status == "add"
                            ? peopleController.postDataThatHaveFile()
                            : peopleController.putData(caseID);
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
