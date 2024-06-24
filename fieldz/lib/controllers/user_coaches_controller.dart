import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachesController extends GetxController {
  final RxList coaches = [].obs;
  RxBool isLoaded = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() async {
    await getCoaches();
    super.onInit();
  }

  getCoaches() async {
    isLoaded.value = false;
    await FirebaseFirestore.instance.collection("coaches").get().then((event) {
      coaches.clear();
      for (var doc in event.docs) {
        var data = doc.data();
        var coach = Coach(
            doc.id,
            data['email'],
            data['username'],
            data['phoneNumber'],
            data['rating'],
            data['avatarURL'],
            data['sport']);
        coach.availablePlans = data['availablePlans'];
        coach.availableSessions = data['availableSessions'];
        coaches.add(coach);
      }
    });
    isLoaded.value = true;
  }
}
