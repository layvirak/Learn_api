import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_api_app/scr/Screens/ShowData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowData(),
    );
  }
}
