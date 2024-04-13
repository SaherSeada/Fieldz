import 'package:flutter/material.dart';
import 'FieldProfilePage.dart'; // Ensure this is the correct path to your FieldProfilePage

class FieldListPage extends StatelessWidget {
  final List<Map<String, dynamic>> fields = [
    {
      'name': 'Manor House School',
      'location': 'Tagamoa 5, New Cairo',
      'imageUrl': 'assets/stadium.png', // Make sure this is the correct asset path
      'rating': 4, // Assuming rating is an integer
      // ... other details if necessary
    },
    // ... other field entries
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.access_time_filled, color: Colors.black), // Status icon
                  title: Text(fields[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(fields[index]['location']),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldProfilePage(field: fields[index]),
                      ),
                    );
                  },
                ),
                Container(
                  height: 180, // Fixed height for the image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(fields[index]['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            starIndex < fields[index]['rating'] ? Icons.star : Icons.star_border,
                            color: starIndex < fields[index]['rating'] ? Colors.amber : Colors.grey,
                            size: 20,
                          );
                        }),
                      ),
                      Image.asset('assets/Football.png', width: 24) // Replace with actual sport icon asset
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
