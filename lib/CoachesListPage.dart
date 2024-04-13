import 'package:flutter/material.dart';
import 'coachprofilepage.dart'; // Make sure this import matches the filename of your CoachProfilePage

class CoachesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> coaches = [
    {
      'name': 'Name',
      'price': 'Price',
      'imageUrl': 'assets/coach.png', // replace with your image path
      'typeOfSession': 'Type of Session',
      'rating': 4,
      'statusIcon': 'assets/Verify.png', // replace with your image path
      'sportIcon': 'assets/Padel.png', // replace with your image path
    },
    // ... other coach maps
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.black), // Adjust as per design
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
      body: ListView.separated(
        itemCount: coaches.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var coach = coaches[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoachProfilePage(coach: coach),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(coach['imageUrl']),
            ),
            title: Text(coach['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coach['price']),
                Text(coach['typeOfSession']),
              ],
            ),
            trailing: Container(
              width: 96, // Fixed width for the trailing column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    coach['statusIcon'],
                    width: 24, // Match your design
                    height: 24, // Match your design
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                          (idx) => Icon(
                        idx < coach['rating'] ? Icons.star : Icons.star_border,
                        color: idx < coach['rating'] ? Colors.amber : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
