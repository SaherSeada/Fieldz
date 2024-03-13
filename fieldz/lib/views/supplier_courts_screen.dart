import 'package:flutter/material.dart';

class YourCourts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Courts'),
      ),
      body: Center(
        child: Text('Your Courts Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addCourt');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
