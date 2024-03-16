import 'package:flutter/material.dart' as supplier_add_court_view;
import 'package:fieldz/models/supplier_court_model.dart';
import 'package:fieldz/controllers/supplier_add_court_controller.dart';

class AddCourtView extends supplier_add_court_view.StatefulWidget {
  @override
  _AddCourtViewState createState() => _AddCourtViewState();
}

class _AddCourtViewState extends supplier_add_court_view.State<AddCourtView> {
  final supplier_add_court_view.TextEditingController courtNameController =
      supplier_add_court_view.TextEditingController();
  String selectedSport = 'Football'; // Initial value
  final supplier_add_court_view.TextEditingController locationController =
      supplier_add_court_view.TextEditingController();
  final supplier_add_court_view.TextEditingController googleMapsLinkController =
      supplier_add_court_view.TextEditingController();
  final supplier_add_court_view.TextEditingController minCapacityController =
      supplier_add_court_view.TextEditingController();
  final supplier_add_court_view.TextEditingController numCourtsController =
      supplier_add_court_view.TextEditingController();
  final supplier_add_court_view.TextEditingController feesPerHourController =
      supplier_add_court_view.TextEditingController();

  @override
  supplier_add_court_view.Widget build(
      supplier_add_court_view.BuildContext context) {
    return supplier_add_court_view.Scaffold(
      appBar: supplier_add_court_view.AppBar(
        title: supplier_add_court_view.Text('Add Court'),
      ),
      body: supplier_add_court_view.SingleChildScrollView(
        child: supplier_add_court_view.Padding(
          padding: supplier_add_court_view.EdgeInsets.all(20.0),
          child: supplier_add_court_view.Column(
            children: [
              supplier_add_court_view.TextField(
                controller: courtNameController,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Court Name',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.DropdownButtonFormField<String>(
                value: selectedSport,
                items: [
                  supplier_add_court_view.DropdownMenuItem(
                    value: 'Football',
                    child: supplier_add_court_view.Text('Football'),
                  ),
                  supplier_add_court_view.DropdownMenuItem(
                    value: 'Basketball',
                    child: supplier_add_court_view.Text('Basketball'),
                  ),
                  supplier_add_court_view.DropdownMenuItem(
                    value: 'Padel',
                    child: supplier_add_court_view.Text('Padel'),
                  ),
                  supplier_add_court_view.DropdownMenuItem(
                    value: 'Tennis',
                    child: supplier_add_court_view.Text('Tennis'),
                  ),
                  // Add more sports as needed
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSport = value!;
                  });
                },
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.TextField(
                controller: locationController,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Location',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.TextField(
                controller: googleMapsLinkController,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Google Maps Link',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.TextField(
                controller: minCapacityController,
                keyboardType: supplier_add_court_view.TextInputType.number,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Minimum Capacity',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.TextField(
                controller: numCourtsController,
                keyboardType: supplier_add_court_view.TextInputType.number,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Number of Courts to Add',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.TextField(
                controller: feesPerHourController,
                keyboardType: supplier_add_court_view.TextInputType.number,
                decoration: supplier_add_court_view.InputDecoration(
                  labelText: 'Fees per Hour',
                ),
              ),
              supplier_add_court_view.SizedBox(height: 20),
              supplier_add_court_view.ElevatedButton(
                onPressed: () {
                  // Create a court object from the entered data
                  Court court = Court(
                    courtName: courtNameController.text,
                    selectedSport: selectedSport,
                    location: locationController.text,
                    googleMapsLink: googleMapsLinkController.text,
                    minCapacity: int.tryParse(minCapacityController.text) ?? 0,
                    numCourts: int.tryParse(numCourtsController.text) ?? 0,
                    feesPerHour:
                        double.tryParse(feesPerHourController.text) ?? 0.0,
                  );
                  // Call the controller to handle form submission
                  AddCourtController().submitForm(court);
                },
                child: supplier_add_court_view.Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
