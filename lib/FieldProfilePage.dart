import 'package:flutter/material.dart';

class FieldProfilePage extends StatelessWidget {
  // Replace with your actual data model
  final Map<String, dynamic> fieldData = {
    'name': 'Manor House School',
    'ownerEmail': 'example@mail.com',
    'ownerPhone': '0101234567',
    'fieldPhone': '0101234567',
    'status': 'Accepted', // Assuming this is the current status
    'imageUrl': 'assets/stadium.png', // Make sure this asset is added to pubspec.yaml
    'rating': 4, // Example rating value
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Field Name', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Handle edit action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8), // Spacing at the top
            // Field Image
            Image.asset(
              fieldData['imageUrl'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Failed to load image'));
              },
            ),
            // Field Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Field Name', fieldData['name']),
                  _buildDetailRow('Owner Email', fieldData['ownerEmail']),
                  _buildDetailRow('Owner Phone Number', fieldData['ownerPhone']),
                  _buildDetailRow('Field Phone Number', fieldData['fieldPhone']),
                  _buildDropdown(fieldData['status']),
                  SizedBox(height: 8), // Spacing before rating stars
                  _buildRating(fieldData['rating']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value, style: TextStyle(color: Colors.grey[600]))),
        ],
      ),
    );
  }

  Widget _buildDropdown(String currentStatus) {
    // Dropdown for status with 'Accepted' as the current value
    return DropdownButton<String>(
      value: currentStatus,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        // Update the state with the new status
      },
      items: <String>['Accepted', 'Pending', 'Rejected'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }
}

void main() => runApp(MaterialApp(home: FieldProfilePage()));
