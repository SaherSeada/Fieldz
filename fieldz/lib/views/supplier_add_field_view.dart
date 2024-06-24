import 'package:fieldz/controllers/supplier_add_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/theme/theme_constants.dart';
import 'package:get/get.dart';

class SupplierAddFieldView extends StatelessWidget {
  SupplierAddFieldView({super.key});

  final SupplierAddFieldController controller =
      Get.put(SupplierAddFieldController());

  @override
  Widget build(BuildContext context) {
    return Theme(
        // Apply theme here
        data: ThemeData(
          brightness: Brightness.light, // Default to light theme
          primaryColor: COLOR_PRIMARY,
          hintColor: COLOR_ACCENT,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: COLOR_ACCENT),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
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
            title: const Text('Add a Field'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Court Name Text Field
                    TextFormField(
                      controller: controller.fieldNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify a field name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Field Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sport Text Field
                    TextFormField(
                      controller: controller.sportController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify a sport";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Sport',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Location Text Field
                    TextFormField(
                      controller: controller.locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify a location";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Google Maps Link Text Field
                    TextFormField(
                      controller: controller.mapsLinkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to provide a google maps link";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Google Maps Link',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Phone Number Text Field
                    TextFormField(
                      controller: controller.phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to provide a phone number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Field Phone Number',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Minimum Capacity Text Field
                    TextFormField(
                      controller: controller.minCapacityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify the minimum capacity per court";
                        } else if (double.tryParse(value) == null) {
                          return "Minimum Capacity has to be a numeric value";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Minimum Capacity',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Number of Courts Text Field
                    TextFormField(
                      controller: controller.numberOfCourtsController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify the number of courts in your field";
                        } else if (double.tryParse(value) == null) {
                          return "Number of Courts has to be a numeric value";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Number of Courts',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Fees Per Hour Text Field
                    TextFormField(
                      controller: controller.feesPerHourController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You have to specify the fees per hour";
                        } else if (double.tryParse(value) == null) {
                          return "Fees per hour has to be a numeric value";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Fees Per Hour',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Done Button
                    ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.submitForm();
                        }
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
