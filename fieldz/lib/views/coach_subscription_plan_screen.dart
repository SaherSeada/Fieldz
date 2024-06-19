import 'package:fieldz/controllers/coach_subscription_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachSubscriptionPlanPage extends StatelessWidget {
  CoachSubscriptionPlanPage({super.key});

  final CoachSubscriptionPlanController controller =
      Get.put(CoachSubscriptionPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text("Subscription Plan"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(17),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Build your schedule table",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.daysOfWeek.length,
                        itemBuilder: (context, index) {
                          String day = controller.daysOfWeek[index];
                          return Obx(() => CheckboxListTile(
                                title: Text(day),
                                value: controller.selectedDays[day]?.value,
                                onChanged: (bool? value) {
                                  controller.selectedDays[day]?.value = value!;
                                },
                                subtitle: controller.selectedDays[day]!.value
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: GestureDetector(
                                          onTap: () => controller.selectTime(
                                              context, day),
                                          child: Text(
                                            'Time: ${controller.selectedTimes[day]}',
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14),
                                          ),
                                        ))
                                    : null,
                              ));
                        },
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        "Fill in your Program details here",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Program Name",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a description";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Description",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.locationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a meeting location";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Meeting Location",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.durationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a duration";
                          }
                          if (double.tryParse(value) == null) {
                            return "Duration must be a numeric value";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Duration in Hours",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Price must be a numeric value";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Price per Month",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.capacityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a maximum capacity";
                          }
                          if (int.tryParse(value) == null) {
                            return "Capacity must be an integer value";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Maximum Capacity",
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.addProgram();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Add Subscription Plan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            )));
  }
}
