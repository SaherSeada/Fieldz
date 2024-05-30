import 'package:fieldz/controllers/user_product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProductDetailsScreen extends StatelessWidget {
  UserProductDetailsScreen({super.key});

  final UserProductDetailsController controller =
      Get.put(UserProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Title'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => controller.isLoaded.value
                ? SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image.network(
                          'https://via.placeholder.com/400',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.productDetails['name'] ?? "",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${controller.productDetails['price'] ?? ""} EGP",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.productDetails['description'] ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Location:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.productDetails['location'] ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Owner:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.productDetails['ownerName'] ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Phone:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.productDetails['phoneNumber'] ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8)
                    ],
                  ))
                : const Center(child: CircularProgressIndicator()),
          )),
    );
  }
}
