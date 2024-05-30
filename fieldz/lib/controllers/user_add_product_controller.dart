import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final photoController = TextEditingController();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      final productData = {
        'imageURL': photoController.text,
        'name': titleController.text,
        'price': double.parse(priceController.text),
        'description': descriptionController.text,
        'phoneNumber': phoneNumberController.text,
      };
      try {
        await FirebaseFirestore.instance
            .collection('products')
            .add(productData);
      } catch (e) {
        return;
      }
    }
  }
}
