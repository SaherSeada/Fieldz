import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/field.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:get/get.dart';

class AdminFieldsController extends GetxController {
  RxBool isLoaded = false.obs;

  final RxList pendingFields = [].obs;
  final RxList activeFields = [].obs;
  final RxList rejectedFields = [].obs;

  @override
  void onInit() async {
    await getFields();
    super.onInit();
  }

  getFields() async {
    isLoaded.value = false;
    pendingFields.clear();
    activeFields.clear();
    rejectedFields.clear();
    try {
      await FirebaseFirestore.instance.collection("fields").get().then((event) {
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
          field.supplierID = data['supplier_id'];
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
    } catch (e) {
      messageDialog("Something Went Wrong!", 'Please try again.');
    }
    isLoaded.value = true;
  }
}
