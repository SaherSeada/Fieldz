import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SupplierDashboardController extends GetxController {
  @override
  void onInit() async {
    // final Map schedule = {};
    // final now = DateTime.now();
    // final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;

    // for (int i = now.day; i <= lastDayOfMonth; i++) {
    //   final date =
    //       "${now.year}-${formatTwoDigits(now.month)}-${formatTwoDigits(i)}";
    //   final hours = generateHours();
    //   schedule[date] = {
    //     "hours": hours[0],
    //     "hours_availability": hours[1]
    //   };
    // }
    // // print(schedule);
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection('fields').get();
    // // Loop through documents
    // querySnapshot.docs.forEach((doc) async {
    //   Map<String, dynamic> newData = {
    //     'availability': schedule
    //   };

    //   // Update document with the new field
    //   await FirebaseFirestore.instance
    //       .collection('fields')
    //       .doc(doc.id)
    //       .update(newData);
    // });
    super.onInit();
  }

  List generateHours() {
    List hours = [];
    List hoursAvailability = [];
    for (int hour = 12; hour <= 27; hour++) {
      hours.add((hour % 24).toString().padLeft(2, '0'));
      hoursAvailability.add(true);
    }
    return [hours, hoursAvailability];
  }

  String formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
