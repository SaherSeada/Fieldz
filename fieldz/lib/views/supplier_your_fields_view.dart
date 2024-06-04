import 'package:fieldz/controllers/supplier_your_fields_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Active Fields",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          SizedBox(
              height: controller.activeFields.length * 175,
              child: ListView.builder(
                itemCount: controller.activeFields.length,
                itemBuilder: (context, index) {
                  var field = controller.activeFields[index];
                  return fieldWidget(field);
                },
              )),
          // const Divider(color: Colors.black),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Pending Fields",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          SizedBox(
              height: controller.activeFields.length * 175,
              child: ListView.builder(
                itemCount: controller.pendingFields.length,
                itemBuilder: (context, index) {
                  var field = controller.pendingFields[index];
                  return fieldWidget(field);
                },
              )),
        ])));
  }

  fieldWidget(field) {
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
          field.status == 'confirmed' ? 'Confirmed' : 'Pending',
          style: TextStyle(
            color: field.status == 'confirmed' ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          field.status == 'confirmed' ? Icons.check_circle : Icons.info,
          color: field.status == 'confirmed' ? Colors.green : Colors.orange,
        ),
        onTap: () {
          // Add functionality to navigate to field details screen
        },
      ),
    );
  }
}
