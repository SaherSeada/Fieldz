import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants

class SupplierProfileView extends StatelessWidget {
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
          title: Text('Profile'),
        ),
        body: Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
