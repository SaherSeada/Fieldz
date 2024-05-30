import 'package:flutter/material.dart';
import 'package:get/get.dart';

void messageDialog(String title, String message) {
  Get.dialog(
    AlertDialog(
      title: Center(child: Text(title)),
      content: Text(message,
          textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
