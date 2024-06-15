import 'package:fieldz/controllers/admin_field_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminFieldDetailsPage extends StatelessWidget {
  AdminFieldDetailsPage({super.key});

  final AdminFieldDetailsController controller =
      Get.put(AdminFieldDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.field.name),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Obx(() => controller.isLoaded.value
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      controller.field.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                              label: 'Field Name',
                              value: controller.field.name,
                              context: context),
                          _buildTextField(
                              label: 'Location',
                              value: controller.field.location,
                              context: context),
                          _buildTextField(
                              label: 'Price',
                              value: '${controller.field.price} EGP / Hour',
                              context: context),
                          _buildTextField(
                              label: 'Sport',
                              value: controller.field.sport[0].toUpperCase() +
                                  controller.field.sport.substring(1),
                              context: context),
                          _buildTextField(
                              label: 'Owner Email',
                              value: controller.supplierEmail,
                              context: context),
                          _buildTextField(
                              label: 'Owner Phone Number',
                              value: controller.supplierPhone,
                              context: context),
                          _buildTextField(
                              label: 'Field Phone Number',
                              value: controller.field.phone,
                              context: context),
                          const SizedBox(height: 5),
                          _buildRating(controller.field.rating),
                          const SizedBox(height: 22),
                          _buildTextField(
                              label: 'Status',
                              value: controller.field.status![0].toUpperCase() +
                                  controller.field.status!.substring(1),
                              context: context),
                          controller.field.status == "pending"
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.onPressed('verified');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green, // Background color
                                        ),
                                        child: const Text('Verify'),
                                      ),
                                      const SizedBox(
                                          width:
                                              20), // Add space between the buttons
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.onPressed('rejected');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red, // Background color
                                        ),
                                        child: const Text('Reject'),
                                      ),
                                    ],
                                  ))
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator())));
  }

  Widget _buildTextField(
      {required String label,
      required String value,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: value),
            enabled: false,
            decoration: InputDecoration(
                hintText: 'e.g. ${label.split(' ').last}',
                disabledBorder: const UnderlineInputBorder(),
                border: const UnderlineInputBorder()),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(int rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text("Rating",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Icon(index < rating ? Icons.star : Icons.star_border,
              color: index < rating ? Colors.amber : Colors.grey, size: 24);
        }),
      )
    ]);
  }
}
