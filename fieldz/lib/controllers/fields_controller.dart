import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FieldsController extends GetxController {
  final RxList fields = [].obs;
  final RxList days = [].obs;
  RxInt selectedFilterIndex = 0.obs;

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(currentDate);
      days.add(dayName);
    }
    await getFields();
    super.onInit();
  }

  getFields() async {
    isLoaded.value = false;
    await FirebaseFirestore.instance.collection("fields").get().then((event) {
      fields.clear();
      for (var doc in event.docs) {
        var data = doc.data();
        var field = Field(data['name'], data['location'], data['price'], data['rating'], data['imageURL']);
        fields.add(field);
      }
    });
    isLoaded.value = true;
  }
}
