import 'package:fieldz/controllers/coach_edit_sessions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachEditSessionsPage extends StatelessWidget {
  CoachEditSessionsPage({super.key});

  final CoachEditSessionsController controller =
      Get.put(CoachEditSessionsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text("Quick Session"),
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
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () => Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                controller.cancelSession();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Cancel Session",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                          const SizedBox(height: 10),
                          const Text(
                            "Edit your Session here",
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
                                return "Please enter a session name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Session Name",
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.durationController,
                            enabled: controller.canEdit.value,
                            keyboardType: TextInputType.number,
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
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.priceController,
                            enabled: controller.canEdit.value,
                            keyboardType: TextInputType.number,
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
                                labelText: "Price",
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.capacityController,
                            enabled: controller.canEdit.value,
                            keyboardType: TextInputType.number,
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
                                labelText: "Capacity",
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Select Date & Time",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.dateController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please select a date";
                                    }
                                    return null;
                                  },
                                  onTap: controller.canEdit.value
                                      ? () async {
                                          DateTime? picked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100));
                                          if (picked != null) {
                                            controller.dateController.text =
                                                picked.toString().split(" ")[0];
                                          }
                                        }
                                      : () {},
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.timeController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey,
                                      prefixIcon: Icon(Icons.timer),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please select a time";
                                    }
                                    return null;
                                  },
                                  onTap: controller.canEdit.value
                                      ? () async {
                                          final TimeOfDay? picked =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (picked != null) {
                                            controller.timeController.text =
                                                picked.format(context);
                                          }
                                        }
                                      : () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          controller.canEdit.value
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.editSession();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Edit Session",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
