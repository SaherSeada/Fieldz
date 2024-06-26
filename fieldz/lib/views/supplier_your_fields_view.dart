import 'package:fieldz/controllers/supplier_your_fields_controller.dart';
import 'package:fieldz/models/field.dart';
import 'package:fieldz/views/supplier_add_field_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierYourFieldsView extends StatelessWidget {
  SupplierYourFieldsView({super.key});

  final SupplierYourFieldsController controller =
      Get.put(SupplierYourFieldsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Fields'),
        ),
        floatingActionButton: ElevatedButton(
          child: const Text("Add A Field"),
          onPressed: () {
            Get.to(() => SupplierAddFieldView());
          },
        ),
        body: SingleChildScrollView(
            child: Obx(() =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Active Fields",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  controller.activeFields.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.activeFields.length,
                          itemBuilder: (context, index) {
                            var field = controller.activeFields[index];
                            return fieldWidget(field);
                          },
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Center(
                              child: Text("No Active Fields",
                                  style: TextStyle(fontSize: 16)))),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Pending Fields",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  controller.pendingFields.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.pendingFields.length,
                          itemBuilder: (context, index) {
                            var field = controller.pendingFields[index];
                            return fieldWidget(field);
                          },
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Center(
                              child: Text("No Pending Fields",
                                  style: TextStyle(fontSize: 16)))),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Rejected Fields",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  controller.rejectedFields.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.rejectedFields.length,
                          itemBuilder: (context, index) {
                            var field = controller.rejectedFields[index];
                            return fieldWidget(field);
                          },
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Center(
                              child: Text("No Rejected Fields",
                                  style: TextStyle(fontSize: 16)))),
                ]))));
  }

  fieldWidget(Field field) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(field.imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          field.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          field.status![0].toUpperCase() + field.status!.substring(1),
          style: TextStyle(
            color: field.status == 'verified'
                ? Colors.green
                : field.status == 'pending'
                    ? Colors.orange
                    : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          field.status == 'verified'
              ? Icons.check_circle
              : field.status == 'pending'
                  ? Icons.info
                  : Icons.warning,
          color: field.status == 'verified'
              ? Colors.green
              : field.status == 'pending'
                  ? Colors.orange
                  : Colors.red,
        ),
        onTap: () {
          // Add functionality to navigate to field details screen
        },
      ),
    );
  }
}
