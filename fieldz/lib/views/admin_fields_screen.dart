import 'package:flutter/material.dart';
import 'admin_field_details_screen.dart';

class FieldListPage extends StatelessWidget {
  final List<Map<String, dynamic>> fields = [
    {
      'name': 'Manor House School',
      'location': 'Tagamoa 5, New Cairo',
      'imageUrl': 'images/stadium.png',
      'rating': 4,
    },
    // Add more field maps here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FieldProfilePage(fieldData: fields[index]),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          fields[index]['imageUrl'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time_filled, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'Status',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fields[index]['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          fields[index]['location'],
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < fields[index]['rating'] ? Icons.star : Icons.star_border,
                              color: starIndex < fields[index]['rating'] ? Colors.amber : Colors.grey,
                            );
                          }),
                        ),
                      ],
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
