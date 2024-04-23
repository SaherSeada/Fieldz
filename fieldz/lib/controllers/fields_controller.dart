import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FieldsController extends GetxController {
  final RxList fields = [].obs;
  final RxList allFields = [].obs;
  final RxList days = [].obs;
  RxInt selectedFilterIndex = 0.obs;

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(currentDate);
      days.add({"dayName": dayName, "date": "${currentDate.year}-${formatTwoDigits(currentDate.month)}-${formatTwoDigits(currentDate.day)}"});
    }
    await getFields();
    super.onInit();
  }

  getFields() async {
    isLoaded.value = false;
    await FirebaseFirestore.instance.collection("fields").get().then((event) {
      allFields.clear();
      for (var doc in event.docs) {
        var data = doc.data();
        var field = Field(doc.id, data['name'], data['location'], data['price'], data['rating'], data['imageURL'], data['availability']);
        allFields.add(field);
      }
    });
    getFieldsByDay();
    isLoaded.value = true;
  }

  getFieldsByDay() {
    isLoaded.value = false;
    var selectedDate = days[selectedFilterIndex.value]['date'];
    fields.clear();
    for (var field in allFields) {
      if (field.availability[selectedDate] != null) {
        fields.add(field);
      }
    }
    isLoaded.value = true;
  }

  String formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
