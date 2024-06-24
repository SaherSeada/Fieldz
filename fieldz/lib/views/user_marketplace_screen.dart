import 'package:fieldz/controllers/user_marketplace_controller.dart';
import 'package:fieldz/views/user_add_product_screen.dart';
import 'package:fieldz/views/user_product_details_screen.dart';
import 'package:fieldz/views/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMarketplaceScreen extends StatelessWidget {
  UserMarketplaceScreen({super.key});

  final UserMarketplaceController controller =
      Get.put(UserMarketplaceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Marketplace",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            toolbarHeight: 60),
        drawer: userDrawer(),
        floatingActionButton: ElevatedButton(
          child: const Text("Add a Product"),
          onPressed: () {
            Get.to(UserCreateProductScreen());
          },
        ),
        body: Obx(() => controller.isLoaded.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.getProducts();
                },
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 10, 7, 0),
                    child: SizedBox(
                        width: Get.width - 25,
                        child: TextField(
                            controller: controller.searchController,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              labelText: 'Search',
                              labelStyle: const TextStyle(fontSize: 18),
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))),
                  ),
                  Expanded(
                      child: GridView.builder(
                    itemCount: controller.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.77),
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: GridTile(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => UserProductDetailsScreen(),
                                    arguments: {'productID': product.id});
                              },
                              child: Card(
                                color: Colors.grey.shade200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Product image
                                    SizedBox(
                                        height: 125,
                                        child: Center(
                                          child: Image.network(
                                            product.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    // Product title
                                    SizedBox(
                                        height: 55,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 3),
                                                child: Center(
                                                  child: Text(
                                                    product.title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blue.shade800),
                                                  ),
                                                )))),
                                    const SizedBox(height: 5),
                                    // Product price
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 8.0, bottom: 8.0),
                                      child: Center(
                                          child: Text(
                                        '${product.price.toStringAsFixed(2)} EGP',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ))
                ]))
            : const Center(child: CircularProgressIndicator())));
  }
}
