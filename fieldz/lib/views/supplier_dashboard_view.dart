import 'package:fieldz/controllers/supplier_dashboard_controller.dart';
import 'package:fieldz/views/login.dart';
import 'package:fieldz/views/supplier_help_view.dart';
import 'package:fieldz/views/supplier_profile_view.dart';
import 'package:fieldz/views/supplier_reports_view.dart';
import 'package:fieldz/views/supplier_your_fields_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart';
import 'package:get/get.dart';

class SupplierDashboardView extends StatelessWidget {
  SupplierDashboardView({super.key});

  final SupplierDashboardController controller =
      Get.put(SupplierDashboardController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                  height: 125.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text('Menu',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )),
              // Drawer menu items
              ListTile(
                title: const Text('Profile'),
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
                title: const Text('Your Courts'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Your Courts page
                  Get.to(() => SupplierYourFieldsView());
                },
              ),
              ListTile(
                title: const Text('Reports'),
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
                title: const Text('Help'),
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
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(() => Login());
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
