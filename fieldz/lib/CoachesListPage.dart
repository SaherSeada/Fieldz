import 'package:flutter/material.dart';
import 'CoachProfilePage.dart';

class CoachesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> coaches = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'imageUrl': 'https://via.placeholder.com/150',
      'typeOfSession': 'Personal Training',
      'rating': 5.0,
      'statusIcon': Icons.check_circle_outline,
      'status': 'Available'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coaches'),
        backgroundColor: Colors.deepPurple, // Color changed to match design
      ),
      body: ListView.separated(
        itemCount: coaches.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var coach = coaches[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(coach['imageUrl']),
            ),
            title: Text(coach['name']),
            subtitle: Row(
              children: [
                Icon(coach['statusIcon']),
                SizedBox(width: 8),
                Text('${coach['typeOfSession']} (${coach['rating']} stars)'),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoachProfilePage(coach: coach)),
              );
            },
          );
        },
      ),
    );
  }
}
