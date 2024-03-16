import 'package:flutter/material.dart';

class SupplierPendingCourtsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Courts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pending Courts Page',
              style: TextStyle(fontSize: 20),
            ),
            // Add any other widgets or functionalities as needed
          ],
        ),
      ),
    );
  }
}
