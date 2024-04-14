import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants

class SupplierPendingCourtsView extends StatelessWidget {
  const SupplierPendingCourtsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pending Courts'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pending Courts Page',
                style: TextStyle(fontSize: 20),
              ),
              // Add any other widgets or functionalities as needed
            ],
          ),
        ),
      ),
    );
  }
}
