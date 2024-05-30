import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserProductDetailsController extends GetxController {
  Map? arguments;
  RxBool isLoaded = false.obs;
  late String productID;
  Map productDetails = {};

  @override
  void onInit() async {
    arguments = Get.arguments;
    productID = arguments?['productID'];
    await getProdcutDetails();
    isLoaded.value = true;
    super.onInit();
  }

  getProdcutDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("products")
          .doc(productID)
          .get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        productDetails = data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
