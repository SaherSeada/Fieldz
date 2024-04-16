import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDrawerController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void closeDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openEndDrawer();
    }
  }
}
