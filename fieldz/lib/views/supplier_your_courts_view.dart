import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants

class YourCourtsView extends StatelessWidget {
  final Function() onAddCourtPressed;

  YourCourtsView({required this.onAddCourtPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: COLOR_ACCENT,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Courts'),
        ),
        body: Center(
          child: Text('Your Courts Page'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onAddCourtPressed,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
