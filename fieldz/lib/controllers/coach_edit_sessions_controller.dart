import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/coach_activity_controller.dart';
import 'package:fieldz/models/session.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachEditSessionsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Map? arguments;
  late Session session;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? coachID;

  RxBool canEdit = false.obs;
  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    arguments = Get.arguments;
    session = arguments?['session'];
    initializeFields();
    await getCoachID();
    isLoaded.value = true;
    super.onInit();
  }

  initializeFields() {
    dateController.text = session.date;
    timeController.text = session.time;
    nameController.text = session.name;
    locationController.text = session.location;
    descriptionController.text = session.description;
    capacityController.text = session.capacity.toString();
    durationController.text = session.duration.toString();
    priceController.text = session.price.toString();
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

  editSession() async {
    isLoaded.value = false;
    final sessionData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': double.parse(priceController.text),
      'location': locationController.text,
      'duration': double.parse(durationController.text),
      'capacity': int.parse(capacityController.text),
      'date': dateController.text,
      'time': timeController.text,
    };
    try {
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(session.id)
          .update(sessionData);
      CoachActivityController activityController = Get.find();
      activityController.refreshData();
      Get.back();
      snackBar("Session Updated Successfully!");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }

  cancelSession() async {
    isLoaded.value = false;
    try {
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(session.id)
          .update({'status': 'cancelled'});
      CoachActivityController activityController = Get.find();
      activityController.refreshData();
      Get.back();
      snackBar("Session Cancelled Successfully!");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }
}
