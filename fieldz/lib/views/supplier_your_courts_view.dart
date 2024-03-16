import 'package:flutter/material.dart';

class YourCourtsView extends StatelessWidget {
  final Function() onAddCourtPressed;

  YourCourtsView({required this.onAddCourtPressed});

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
        onPressed: onAddCourtPressed,
        child: Icon(Icons.add),
      ),
    );
  }
}
