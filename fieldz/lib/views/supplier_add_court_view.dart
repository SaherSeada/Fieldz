import 'package:flutter/material.dart';
import 'package:fieldz/models/supplier_court_model.dart';
import 'package:fieldz/controllers/supplier_add_court_controller.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants

class AddCourtView extends StatefulWidget {
  @override
  _AddCourtViewState createState() => _AddCourtViewState();
}

class _AddCourtViewState extends State<AddCourtView> {
  final TextEditingController courtNameController = TextEditingController();
  String selectedSport = 'Football'; // Initial value
  final TextEditingController locationController = TextEditingController();
  final TextEditingController googleMapsLinkController =
      TextEditingController();
  final TextEditingController minCapacityController = TextEditingController();
  final TextEditingController numCourtsController = TextEditingController();
  final TextEditingController feesPerHourController = TextEditingController();

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
          title: Text('Add Court'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: courtNameController,
                  decoration: InputDecoration(
                    labelText: 'Court Name',
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedSport,
                  items: [
                    DropdownMenuItem(
                      value: 'Football',
                      child: Text('Football'),
                    ),
                    DropdownMenuItem(
                      value: 'Basketball',
                      child: Text('Basketball'),
                    ),
                    DropdownMenuItem(
                      value: 'Padel',
                      child: Text('Padel'),
                    ),
                    DropdownMenuItem(
                      value: 'Tennis',
                      child: Text('Tennis'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedSport = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: googleMapsLinkController,
                  decoration: InputDecoration(
                    labelText: 'Google Maps Link',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: minCapacityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Minimum Capacity',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: numCourtsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Courts to Add',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: feesPerHourController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fees per Hour',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Create a court object from the entered data
                    Court court = Court(
                      courtName: courtNameController.text,
                      selectedSport: selectedSport,
                      location: locationController.text,
                      googleMapsLink: googleMapsLinkController.text,
                      minCapacity:
                          int.tryParse(minCapacityController.text) ?? 0,
                      numCourts: int.tryParse(numCourtsController.text) ?? 0,
                      feesPerHour:
                          double.tryParse(feesPerHourController.text) ?? 0.0,
                    );
                    // Call the controller to handle form submission
                    AddCourtController().submitForm(court);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
