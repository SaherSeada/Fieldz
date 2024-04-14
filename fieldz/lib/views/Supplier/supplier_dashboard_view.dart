import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants
import 'package:fieldz/views/Supplier/Menu/supplier_profile_view.dart';
import 'package:fieldz/views/supplier/Menu/supplier_pending_courts_view.dart';
import 'package:fieldz/views/Supplier/Menu/addCourt/supplier_your_courts_view.dart';
import 'package:fieldz/views/supplier/Menu/Help/supplier_help_view.dart';
import 'package:fieldz/views/supplier/Menu/supplier_reports_view.dart';

class SupplierDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
      ),
      child: Scaffold(
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
                  // Navigate to Profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SupplierProfileView()),
                  );
                },
              ),
              ListTile(
                title: Text('Pending Courts'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Pending Courts page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupplierPendingCourtsView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Your Courts'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Your Courts page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupplierYourCourtsView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Reports'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Pending Courts page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupplierReportsView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Help'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Pending Courts page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupplierHelpView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Welcome to the Dashboard!'),
        ),
      ),
    );
  }
}
