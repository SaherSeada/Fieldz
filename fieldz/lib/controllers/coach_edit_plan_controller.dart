import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/coach_activity_controller.dart';
import 'package:fieldz/models/program.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachEditSubscriptionPlanController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  String? coachID;

  Map? arguments;
  late Program program;

  RxBool canEdit = false.obs;
  RxBool isLoaded = false.obs;

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
    arguments = Get.arguments;
    program = arguments?['program'];
    initializeFields();
    await getCoachID();
    isLoaded.value = true;
    super.onInit();
  }

  initializeFields() {
    nameController.text = program.name;
    locationController.text = program.location;
    descriptionController.text = program.description;
    durationController.text = program.duration.toString();
    capacityController.text = program.capacity.toString();
    priceController.text = program.price.toString();
    program.schedule.forEach((key, value) {
      selectedDays[key]?.value = true;
      selectedTimes[key]?.value = value;
    });
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

  editProgram() async {
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
    };
    try {
      await FirebaseFirestore.instance
          .collection('programs')
          .doc(program.id)
          .update(programData);
      CoachActivityController activityController = Get.find();
      activityController.refreshData();
      Get.back();
      snackBar("Program Edited Successfully!");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }

  cancelProgram() async {
    isLoaded.value = false;
    try {
      await FirebaseFirestore.instance
          .collection('programs')
          .doc(program.id)
          .update({'status': 'cancelled'});
      CoachActivityController activityController = Get.find();
      activityController.refreshData();
      Get.back();
      snackBar("Subscription Plan Cancelled Successfully!");
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
  }
}
