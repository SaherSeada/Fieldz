import 'package:fieldz/views/supplier/Menu/addCourt/supplier_form_view.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants

class SupplierYourCourtsView extends StatelessWidget {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Form fields
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupplierFormView()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
