import 'package:fieldz/views/supplier_your_courts_view.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart';

class SupplierFormView extends StatelessWidget {
  const SupplierFormView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
        hintColor: COLOR_ACCENT,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Supplier Form'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Court Name Text Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Court Name',
                  ),
                ),
                SizedBox(height: 20),
                // Sport Text Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Sport',
                  ),
                ),
                SizedBox(height: 20),
                // Location Text Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                SizedBox(height: 20),
                // Google Maps Link Text Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Google Maps Link',
                  ),
                ),
                SizedBox(height: 20),
                // Minimum Capacity Text Field
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Minimum Capacity',
                  ),
                ),
                SizedBox(height: 20),
                // Number of Courts Text Field
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Courts',
                  ),
                ),
                SizedBox(height: 20),
                // Fees Per Hour Text Field
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fees Per Hour',
                  ),
                ),
                SizedBox(height: 20),
                // Done Button
                ElevatedButton(
                  onPressed: () {
                    // When done button is pressed, go back to previous page
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplierYourCourtsView()),
                    );
                  },
                  child: Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
