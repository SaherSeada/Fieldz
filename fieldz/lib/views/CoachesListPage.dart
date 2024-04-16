import 'package:flutter/material.dart';
import 'CoachProfilePage.dart'; // Make sure this path is correct.

class CoachesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> coaches = [
    {
      'name': 'John Doe',
      'price': '\$40/session',
      'typeOfSession': 'Personal Training',
      'rating': 4,
      'imageUrl': 'images/Coach.png',
      'statusIcon': 'images/Verify.png',
      'sportIcon': 'images/Padel.png',
    },
    // ... other coach data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.black),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          var coach = coaches[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoachProfilePage(coach: coach),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(coach['imageUrl']),
              ),
              title: Text(coach['name']),
              subtitle: Text('${coach['price']} - ${coach['typeOfSession']}'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Image.asset(coach['statusIcon'], width: 24),
                  Image.asset(coach['sportIcon'], width: 24), // Sport icon
                  Icon(Icons.chevron_right), // If needed for navigation arrow
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
