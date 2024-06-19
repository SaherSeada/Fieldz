import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachSessionsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? coachID;

  @override
  void onInit() async {
    await getCoachID();
    super.onInit();
  }

  getCoachID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID') ?? "";
    if (userID != "") {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .get();

        if (userSnapshot.exists) {
          coachID = userSnapshot['coachID'];
        }
      } catch (e) {
        messageDialog("Something Went Wrong!", "Please try again.");
      }
    }
  }

  addSession() async {
    final sessionData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': double.parse(priceController.text),
      'location': locationController.text,
      'duration': double.parse(durationController.text),
      'capacity': int.parse(capacityController.text),
      'date': dateController.text,
      'time': timeController.text,
      'coachID': coachID,
      'available': true
    };
    try {
      await FirebaseFirestore.instance.collection('sessions').add(sessionData);
      Get.back();
      snackBar("Session Added Successfully! Users can now book your session.");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }
}
