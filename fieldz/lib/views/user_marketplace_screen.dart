import 'package:fieldz/controllers/user_drawer_controller.dart';
import 'package:fieldz/controllers/user_marketplace_controller.dart';
import 'package:fieldz/views/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMarketplaceScreen extends StatelessWidget {
  UserMarketplaceScreen({super.key});

  final UserMarketplaceController controller =
      Get.put(UserMarketplaceController());

  final UserDrawerController drawerController = UserDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: drawerController.scaffoldKey,
        appBar: AppBar(
            title: const Text("Marketplace",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                drawerController.openDrawer(); // This line opens the drawer
              },
            ),
            backgroundColor: Colors.blueAccent,
            toolbarHeight: 60,
            automaticallyImplyLeading: false),
        drawer: userDrawer(),
        body: Obx(() => controller.isLoaded.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.getProducts();
                },
                child: GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.85),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              // Handle tapping on the product
                            },
                            child: Card(
                              color: Colors.grey.shade200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Product image
                                  SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // Product title
                                  SizedBox(
                                      height: 65,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Text(
                                              product.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade800),
                                            ),
                                          ))),
                                  const SizedBox(height: 5),
                                  // Product price
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 8.0, bottom: 8.0),
                                    child: Text(
                                      '${product.price.toStringAsFixed(2)} EGP',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              )
            : const Center(child: CircularProgressIndicator())));
  }
}
