import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachSubscriptionPlanController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  String? coachID;

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  Map<String, RxBool> selectedDays = {
    'Monday': false.obs,
    'Tuesday': false.obs,
    'Wednesday': false.obs,
    'Thursday': false.obs,
    'Friday': false.obs,
    'Saturday': false.obs,
    'Sunday': false.obs,
  };

  Map<String, RxString> selectedTimes = {
    'Monday': "8:00 AM".obs,
    'Tuesday': "8:00 AM".obs,
    'Wednesday': "8:00 AM".obs,
    'Thursday': "8:00 AM".obs,
    'Friday': "8:00 AM".obs,
    'Saturday': "8:00 AM".obs,
    'Sunday': "8:00 AM".obs,
  };

  @override
  void onInit() async {
    await getCoachID();
    super.onInit();
  }

  Future<void> selectTime(BuildContext context, String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null && picked.format(context) != selectedTimes[day]?.value) {
      selectedTimes[day]?.value = picked.format(context);
    }
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

  addProgram() async {
    Map scheduleMap = {};
    selectedDays.forEach((key, value) {
      if (value.value) {
        scheduleMap[key] = selectedTimes[key]?.value;
      }
    });
    final programData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': double.parse(priceController.text),
      'location': locationController.text,
      'duration': double.parse(durationController.text),
      'capacity': int.parse(capacityController.text),
      'schedule': scheduleMap,
      'coachID': coachID,
      'available': true,
      'status': 'active'
    };
    try {
      await FirebaseFirestore.instance.collection('programs').add(programData);
      Get.back();
      snackBar(
          "Program Added Successfully! Users can now subscribe to your program.");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }
}
