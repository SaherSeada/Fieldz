import 'package:fieldz/controllers/supplier_dashboard_controller.dart';
import 'package:fieldz/views/login.dart';
import 'package:fieldz/views/supplier_profile_view.dart';
import 'package:fieldz/views/supplier_your_fields_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: COLOR_ACCENT),
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
                    Get.back();
                    Get.to(() => SupplierProfileView());
                  },
                ),
                ListTile(
                  title: const Text('Your Courts'),
                  onTap: () {
                    Get.back();
                    // Navigate to Your Courts page
                    Get.to(() => SupplierYourFieldsView());
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
          body: Obx(() => controller.isLoaded.value
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Text("Upcoming Bookings",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      ListView.builder(
                        itemCount: controller.fields.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final field = controller.fields[index];
                          if (controller.upcomingBookings
                              .containsKey(field['id'])) {
                            return fieldWidget(field);
                          }
                          return const SizedBox();
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Text("Past Bookings",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      ListView.builder(
                        itemCount: controller.fields.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final field = controller.fields[index];
                          if (controller.pastBookings
                              .containsKey(field['id'])) {
                            return fieldWidget(field);
                          }
                          return const SizedBox();
                        },
                      )
                    ]))
              : const SizedBox()),
        ));
  }

  fieldWidget(field) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: ExpansionTile(
            title: Text(
              field['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              ListView.builder(
                  itemCount: controller.upcomingBookings[field['id']]?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var booking =
                        controller.upcomingBookings[field['id']]![index];
                    return ListTile(
                      title: Center(
                          child: Text(
                        formatDate(booking.date),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            'Booker Name: ${booking.bookerName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Phone: ${booking.phoneNumber}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Hours Booked: ${booking.details}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Total Paid: ${booking.price.toStringAsFixed(2)} EGP',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          const Divider()
                        ],
                      ),
                    );
                  })
            ]),
      ),
    );
  }

  String formatDate(String dateString) {
    // Parse the input date string
    DateTime date = DateTime.parse(dateString);

    // Format the date to the desired format
    String formattedDate = DateFormat('EEE, d MMMM yyyy').format(date);

    // Add the suffix to the day
    int day = date.day;
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Insert the suffix into the formatted date string
    formattedDate = formattedDate.replaceFirst(RegExp(r'\d+'), '$day$suffix');

    return formattedDate;
  }
}
