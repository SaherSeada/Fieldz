import 'package:flutter/material.dart';

class CoachProfilePage extends StatelessWidget {
  final Map<String, dynamic> coach;

  CoachProfilePage({required this.coach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(coach['imageUrl']),
          ),
          ListTile(
            title: Text('Name'),
            subtitle: Text(coach['name']),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text(coach['email']),
          ),
          ListTile(
            title: Text('Type of Session'),
            subtitle: Text(coach['typeOfSession']),
          ),
          ListTile(
            title: Text('Status'),
            subtitle: Row(
              children: [
                Icon(coach['statusIcon']),
                SizedBox(width: 8),
                Text(coach['status']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
