import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/admin_fields_controller.dart';
import 'package:fieldz/models/field.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:get/get.dart';

class AdminFieldDetailsController extends GetxController {
  late Field field;
  Map? arguments;
  late String supplierEmail;
  late String supplierPhone;

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    arguments = Get.arguments;
    field = arguments?['field'];
    await getSupplierData();
    isLoaded.value = true;
    super.onInit();
  }

  getSupplierData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(field.supplierID)
        .get()
        .then((DocumentSnapshot doc) {
      var supplierData = doc.data() as Map<String, dynamic>;
      supplierEmail = supplierData['email'];
      supplierPhone = supplierData['phoneNumber'];
    });
  }

  onPressed(String newStatus) async {
    isLoaded.value = false;
    try {
      await FirebaseFirestore.instance
          .collection('fields')
          .doc(field.id)
          .update({'status': newStatus});
    } catch (e) {
      isLoaded.value = true;
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
    field.status = newStatus;
    AdminFieldsController fieldsController = Get.find();
    await fieldsController.getFields();
    isLoaded.value = true;
    snackBar("Coach Status updated successfully");
  }
}
