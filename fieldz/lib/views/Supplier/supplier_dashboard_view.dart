import 'package:fieldz/controllers/supplier_dashboard_controller.dart';
import 'package:fieldz/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants
import 'package:fieldz/views/Supplier/Menu/supplier_profile_view.dart';
import 'package:fieldz/views/supplier/Menu/supplier_pending_courts_view.dart';
import 'package:fieldz/views/Supplier/Menu/addCourt/supplier_your_courts_view.dart';
import 'package:fieldz/views/supplier/Menu/Help/supplier_help_view.dart';
import 'package:fieldz/views/supplier/Menu/supplier_reports_view.dart';
import 'package:get/get.dart';

class SupplierDashboardView extends StatelessWidget {
  SupplierDashboardView({super.key});

  final SupplierDashboardController controller = Get.put(SupplierDashboardController());

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
              // Drawer menu items
              const SizedBox(height: 20),
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
                title: const Text('Pending Courts'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Navigate to Pending Courts page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupplierPendingCourtsView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Your Courts'),
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
                  Get.offAll(() => const Login());
                },
              ),
            ],
          ),
        ),
        body: const Center(
          child: Text('Welcome to the Dashboard!'),
        ),
      ),
    );
  }
}
