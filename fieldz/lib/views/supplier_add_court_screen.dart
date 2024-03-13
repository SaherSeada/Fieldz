import 'package:flutter/material.dart';

class AddCourt extends StatefulWidget {
  @override
  _AddCourtState createState() => _AddCourtState();
}

class _AddCourtState extends State<AddCourt> {
  // State variables for form fields
  String _courtName = '';
  String _selectedSport = 'Football'; // Initial value
  String _location = '';
  String _googleMapsLink = '';
  int _minCapacity = 0;
  int _numCourts = 0;
  double _feesPerHour = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Court'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Court Name',
                ),
                onChanged: (value) => setState(() => _courtName = value),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedSport,
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
                  // Add more sports as needed
                ],
                onChanged: (value) => setState(() => _selectedSport = value!),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
                onChanged: (value) => setState(() => _location = value),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Google Maps Link',
                ),
                onChanged: (value) => setState(() => _googleMapsLink = value),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Minimum Capacity',
                ),
                onChanged: (value) =>
                    setState(() => _minCapacity = int.tryParse(value) ?? 0),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Courts to Add',
                ),
                onChanged: (value) =>
                    setState(() => _numCourts = int.tryParse(value) ?? 0),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fees per Hour',
                ),
                onChanged: (value) => setState(
                    () => _feesPerHour = double.tryParse(value) ?? 0.0),
              ),
              SizedBox(height: 20),
              // Removed placeholder buttons
              // ElevatedButton(
              //   onPressed: () => _pickImage(), // Placeholder for image picking
              //   child: Text('Photos (5 minimum)'),
              // ),
              // SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    _submitForm(), // Placeholder for form submission
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Placeholder functions for missing functionalities

  // void _pickImage() {
  //   // Implement image picking functionality here
  // }

  void _submitForm() {
    // Implement form validation and data submission logic.
    // ...
  }
}
