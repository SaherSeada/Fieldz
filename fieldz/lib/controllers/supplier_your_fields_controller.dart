import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/field.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierYourFieldsController extends GetxController {
  late String userID;
  final RxList activeFields = [].obs;
  final RxList pendingFields = [].obs;
  final RxList rejectedFields = [].obs;

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? "";
    await getFields();
    super.onInit();
  }

  getFields() async {
    isLoaded.value = false;
    activeFields.clear();
    pendingFields.clear();
    rejectedFields.clear();
    await FirebaseFirestore.instance
        .collection("fields")
        .where('supplier_id', isEqualTo: userID)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        var field = Field(
            doc.id,
            data['name'],
            data['location'],
            data['phoneNumber'],
            (data['price']).toInt(),
            data['rating'],
            data['imageURL'],
            data['availability'],
            data['sport']);
        field.status = data['status'];
        if (field.status == 'verified') {
          activeFields.add(field);
        } else if (field.status == 'pending') {
          pendingFields.add(field);
        } else {
          rejectedFields.add(field);
        }
      }
    });
    isLoaded.value = true;
  }
}
