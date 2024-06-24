import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMarketplaceController extends GetxController {
  final RxList products = [].obs;
  RxBool isLoaded = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() async {
    await getProducts();
    super.onInit();
  }

  getProducts() async {
    isLoaded.value = false;
    await FirebaseFirestore.instance.collection("products").get().then((event) {
      products.clear();
      for (var doc in event.docs) {
        var data = doc.data();
        var product = Product(
            doc.id, data['name'], data['imageURL'], data['price'].toDouble());
        products.add(product);
      }
    });
    isLoaded.value = true;
  }
}
