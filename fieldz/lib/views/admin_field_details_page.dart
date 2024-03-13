import 'package:flutter/material.dart';

class FieldProfilePage extends StatelessWidget {
  final Map<String, dynamic> field;

  FieldProfilePage({required this.field});

  Widget _buildRatingStars(int? rating) {
    if (rating == null) {
      return Row(
        children: List.generate(5, (index) => Icon(Icons.star_border, color: Colors.amber)),
      );
    }

    List<Widget> stars = List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
      );
    });

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(field['name'] ?? 'Unknown Field'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              field['imageUrl'] as String? ?? 'https://example.com/default_image.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Field Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(field['name'] ?? 'Unknown', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(field['location'] ?? 'No location provided', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(field['status'] ?? 'No status available', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      _buildRatingStars(field['rating'] as int?),
                      Icon(Icons.sports_soccer),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
