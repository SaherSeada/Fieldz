import 'package:flutter/material.dart';

class CoachProfilePage extends StatelessWidget {
  final Map<String, dynamic> coach;

  CoachProfilePage({required this.coach});

  @override
  Widget build(BuildContext context) {
    // Safely get the string values, using empty strings as fallbacks if the value is null
    String name = coach['name'] ?? 'N/A';
    String email = coach['email'] ?? 'N/A';
    String userName = coach['userName'] ?? 'N/A';
    String phone = coach['phone'] ?? 'N/A';
    String status = coach['status'] ?? 'Unverified';
    String imageUrl = coach['imageUrl'] ?? 'assets/default_coach.png'; // Fallback to a default image
    String sportIcon = coach['sportIcon'] ?? 'assets/default_sport.png'; // Fallback to a default sport icon
    int rating = coach['rating'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imageUrl),
          ),
          SizedBox(height: 8),
          Center(
            child: Image.asset(sportIcon, width: 50, height: 50), // Sport Icon
          ),
          SizedBox(height: 8),
          _buildRatingStars(rating),
          _buildInfoSection('Name', name),
          Divider(),
          _buildInfoSection('Email', email),
          Divider(),
          _buildInfoSection('User Name', userName),
          Divider(),
          _buildInfoSection('Phone Number', phone),
          Divider(),
          _buildInfoSection('Status', status),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
          size: 24,
        );
      }),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
