// supplier_dashboard_view.dart
import 'package:flutter/material.dart';

class SupplierDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // Drawer menu items
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Pending Courts'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/pendingcourts');
              },
            ),
            ListTile(
              title: Text('Your Courts'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/yourcourts');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}
