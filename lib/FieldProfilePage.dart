import 'package:flutter/material.dart';

class FieldProfilePage extends StatelessWidget {
  final Map<String, dynamic> fieldData;

  // Constructor
  FieldProfilePage({required this.fieldData});

  @override
  Widget build(BuildContext context) {
    // Null checks with default values
    String imageUrl = fieldData['imageUrl'] as String? ?? 'assets/default_image.png';
    String name = fieldData['name'] as String? ?? 'No name provided';
    String ownerEmail = fieldData['ownerEmail'] as String? ?? 'No email provided';
    String ownerPhone = fieldData['ownerPhone'] as String? ?? 'No phone provided';
    String fieldPhone = fieldData['fieldPhone'] as String? ?? 'No field phone provided';
    String status = fieldData['status'] as String? ?? 'Accepted'; // Default status
    int rating = fieldData['rating'] as int? ?? 0;

    // Ensure that status is one of the valid options
    final List<String> statusOptions = ['Accepted', 'Pending', 'Rejected'];
    if (!statusOptions.contains(status)) {
      status = 'Accepted'; // Default to 'Accepted' if currentStatus is unknown
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(label: 'Field Name', value: name, context: context),
                  _buildTextField(label: 'Owner Email', value: ownerEmail, context: context),
                  _buildTextField(label: 'Owner Phone Number', value: ownerPhone, context: context),
                  _buildTextField(label: 'Field Phone Number', value: fieldPhone, context: context),
                  SizedBox(height: 20),
                  _buildStatusDropdown(status, statusOptions, context),
                  SizedBox(height: 20),
                  _buildRating(rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String value, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextField(
            controller: TextEditingController(text: value),
            decoration: InputDecoration(hintText: 'e.g. ${label.split(' ').last}', border: UnderlineInputBorder()),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(String currentValue, List<String> options, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            value: currentValue,
            onChanged: (String? newValue) {
              // Implement state management logic
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Icon(Icons.sports_soccer), // Replace with your sports icon asset
      ],
    );
  }

  Widget _buildRating(int rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(index < rating ? Icons.star : Icons.star_border, color: index < rating ? Colors.amber : Colors.grey, size: 24);
      }),
    );
  }
}
