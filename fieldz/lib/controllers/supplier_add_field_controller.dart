import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierAddFieldController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fieldNameController = TextEditingController();
  final TextEditingController sportController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mapsLinkController = TextEditingController();
  final TextEditingController minCapacityController = TextEditingController();
  final TextEditingController numberOfCourtsController =
      TextEditingController();
  final TextEditingController feesPerHourController = TextEditingController();

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userID = prefs.getString('userID');
      final fieldData = {
        'name': fieldNameController.text,
        'sport': sportController.text,
        'price': int.parse(feesPerHourController.text),
        'location': locationController.text,
        'imageURL': "",
        'status': 'pending',
        'mapsLink': mapsLinkController.text,
        'minCapacity': minCapacityController.text,
        'numberOfCourts': int.parse(numberOfCourtsController.text),
        'supplier_id': userID,
        'rating': -1,
        'availability': {}
      };
      try {
        await FirebaseFirestore.instance.collection('fields').add(fieldData);
        Get.back();
        snackBar(
            "Field Added Successfully! Our admins will verify your details, and contact you shortly.");
      } catch (e) {
        messageDialog("Something Went Wrong!", "Please try again.");
        return;
      }
    }
  }
}
