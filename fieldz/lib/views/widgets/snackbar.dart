import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar(message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    icon: const Icon(Icons.check_circle_rounded, color: Colors.green),
    duration: const Duration(seconds: 5),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
  ));
}