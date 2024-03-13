import 'package:flutter/material.dart';
import 'admin_field_details_page.dart';

class FieldListPage extends StatelessWidget {
  final List<Map<String, dynamic>> fields = [
    {
      'name': 'Manor House School',
      'location': 'Tagamoa 5, New Cairo',
      'imageUrl': 'https://example.com/images/field1.jpg',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fields'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(fields[index]['imageUrl'], width: 50, height: 50),
              title: Text(fields[index]['name']),
              subtitle: Text(fields[index]['location']),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FieldProfilePage(field: fields[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
