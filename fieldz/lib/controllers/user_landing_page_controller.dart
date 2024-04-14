import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;
  List<BottomNavigationBarItem> bottomNavigationBarItemList = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.newspaper_sharp,
        size: 20.0,
      ),
      label: "Fields",
      backgroundColor: Color.fromARGB(255, 37, 120, 157),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.newspaper_sharp,
        size: 20.0,
      ),
      label: "Coaches",
      backgroundColor: Color.fromARGB(255, 37, 120, 157),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.newspaper_sharp,
        size: 20.0,
      ),
      label: "Marketplace",
      backgroundColor: Color.fromARGB(255, 37, 120, 157),
    )
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
