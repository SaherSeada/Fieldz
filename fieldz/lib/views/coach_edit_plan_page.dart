import 'package:fieldz/controllers/coach_edit_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachEditSubscriptionPlanPage extends StatelessWidget {
  CoachEditSubscriptionPlanPage({super.key});

  final CoachEditSubscriptionPlanController controller =
      Get.put(CoachEditSubscriptionPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text("Subscription Plan"),
          centerTitle: true,
          actions: [
            Obx(() => controller.canEdit.value
                ? TextButton(
                    onPressed: () {
                      controller.canEdit.value = false;
                      controller.initializeFields();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ))
                : IconButton(
                    onPressed: () {
                      controller.canEdit.value = true;
                    },
                    icon: const Icon(Icons.edit)))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(17),
            child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                controller.cancelProgram();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Cancel Subscription Plan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                          const SizedBox(height: 10),
                          const Text(
                            "Edit your schedule table",
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
                              return CheckboxListTile(
                                title: Text(day),
                                value: controller.selectedDays[day]?.value,
                                enabled: controller.canEdit.value,
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
                              );
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                          controller.canEdit.value
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.editProgram();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Edit Subscription Plan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ))
                              : const SizedBox(),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
