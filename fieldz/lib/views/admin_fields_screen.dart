import 'package:fieldz/controllers/admin_fields_controller.dart';
import 'package:fieldz/models/field.dart';
import 'package:fieldz/views/admin_field_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminFieldsPage extends StatelessWidget {
  AdminFieldsPage({super.key});

  final AdminFieldsController controller = Get.put(AdminFieldsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fields"),
          // title: TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Search...',
          //     prefixIcon: Icon(Icons.search),
          //     filled: true,
          //     fillColor: Colors.white,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(20),
          //       borderSide: BorderSide.none,
          //     ),
          //   ),
          // ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getFields();
          },
          child: SingleChildScrollView(
              child: Obx(() => controller.isLoaded.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Pending Fields",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
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
                          const SizedBox(height: 18),
                          const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Active Fields",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
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
                          const SizedBox(height: 18),
                          const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Rejected Fields",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          controller.rejectedFields.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.rejectedFields.length,
                                  itemBuilder: (context, index) {
                                    var field =
                                        controller.rejectedFields[index];
                                    return fieldWidget(field);
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: Text("No Rejected Fields",
                                          style: TextStyle(fontSize: 16))))
                        ])
                  : const Center(child: CircularProgressIndicator()))),
        ));
  }

  fieldWidget(Field field) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AdminFieldDetailsPage(), arguments: {'field': field});
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(12, 10, 12, 17),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    field.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        field.status == 'verified'
                            ? Icons.check_circle
                            : Icons.info,
                        color: field.status == 'verified'
                            ? Colors.green
                            : Colors.orange,
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        field.status![0].toUpperCase() +
                            field.status!.substring(1),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          field.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          field.sport[0].toUpperCase() +
                              field.sport.substring(1),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ]),
                  const SizedBox(height: 5),
                  Text(
                    field.location,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < field.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: starIndex < field.rating
                            ? Colors.amber
                            : Colors.grey,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
