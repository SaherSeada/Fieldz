import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SupplierDashboardController extends GetxController {
  @override
  void onInit() async {
    final Map<String, Map> schedule = {};
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;

    for (int i = now.day; i <= lastDayOfMonth; i++) {
      final date =
          "${now.year}-${formatTwoDigits(now.month)}-${formatTwoDigits(i)}";
      final hours = generateHours();
      schedule[date] = hours;
    }
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('fields').get();
    // Loop through documents
    querySnapshot.docs.forEach((doc) async {
      Map<String, dynamic> newData = {
        'availability': schedule
      };

      // Update document with the new field
      await FirebaseFirestore.instance
          .collection('fields')
          .doc(doc.id)
          .update(newData);
    });
    super.onInit();
  }

  Map generateHours() {
    Map hours = {};
    for (int hour = 12; hour < 24; hour++) {
      hours[(hour % 24).toString()] = true; // Ensure the hour is within 0-23 range
    }
    hours["00"] = true;
    hours["01"] = true;
    hours["02"] = true;
    hours["03"] = true;
    return hours;
  }

  String formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
