import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ShowCard extends StatelessWidget {
  String firstName;
  String lastName;
  String age;
  String activeDate;
  String createdAt;
  String updatedAt;
  Function onTeb;
  ShowCard({this.firstName,this.lastName,this.activeDate,this.age,this.createdAt,this.updatedAt,this.onTeb});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
          margin: EdgeInsets.only(top: 15,left: 20,right: 20,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,width: 2,)
          ),
          child: Row(
            children: [
              Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text("First Name  =>"),
                Text("Last Name  =>"),
                Text("Age=>"),
                Text("activeDate  =>"),
                Text("createdAt=>"),
                Text("updatedAt=>"),
              ],)),
              Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firstName),
                Text(lastName),
                Text(age),
                Text(activeDate),
                Text(createdAt),
                Text(updatedAt),

              ],))
            ],
          ),
        ),
        Positioned(
          top: 10,
            right: 15,
            child: IconButton(

          icon: Icon(Icons.cancel),
          onPressed: ()=>onTeb(),
        )),
      ],
    );
  }
}
