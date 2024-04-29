import 'package:fieldz/controllers/supplier_add_court_controller.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart'; // Import theme constants
import 'package:fieldz/views/Supplier/Menu/addCourt/supplier_your_courts_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // Import SupplierYourCourtsView

class SupplierFormView extends StatelessWidget {
  SupplierFormView({super.key});

  final AddCourtController controller = Get.put(AddCourtController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: ThemeData(
        brightness: Brightness.light, // Default to light theme
        primaryColor: COLOR_PRIMARY,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Court'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Court Name Text Field
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Court Name',
                  ),
                ),
                const SizedBox(height: 15),
                // Sport Text Field
                Obx(() => DropdownButtonFormField(
                    value: controller.selectedSport.value,
                    hint: const Text('Choose a sport'),
                    items: controller.sports
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedSport = value.obs;
                    })),
                const SizedBox(height: 15),
                // Location Text Field
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                const SizedBox(height: 15),
                // Google Maps Link Text Field
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Google Maps Link',
                  ),
                ),
                const SizedBox(height: 15),
                // Minimum Capacity Text Field
                // TextField(
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //     labelText: 'Minimum Capacity',
                //   ),
                // ),
                // SizedBox(height: 20),
                // Number of Courts Text Field
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Courts',
                  ),
                ),
                const SizedBox(height: 15),
                // Fees Per Hour Text Field
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fees Per Hour',
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                    children: [
                      Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Start Time',
                              ))),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'End Time',
                              )))
                    ]),
                const SizedBox(height: 25),
                // Done Button
                ElevatedButton(
                  onPressed: () {
                    // When done button is pressed, go back to previous page
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplierYourCourtsView()),
                    );
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
