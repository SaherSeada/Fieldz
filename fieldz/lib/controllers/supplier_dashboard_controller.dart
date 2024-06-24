import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/field_booking.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierDashboardController extends GetxController {
  List fields = [].obs;

  RxBool isLoaded = false.obs;

  late String userID;

  Map<String, List<FieldBooking>> pastBookings = {};
  Map<String, List<FieldBooking>> upcomingBookings = {};

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? "";
    await getFields();
    await getBookings();
    isLoaded.value = true;
    // final Map schedule = {};
    // final now = DateTime.now();
    // final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;

    // for (int i = now.day; i <= lastDayOfMonth; i++) {
    //   final date =
    //       "${now.year}-${formatTwoDigits(now.month)}-${formatTwoDigits(i)}";
    //   final hours = generateHours();
    //   schedule[date] = {"hours": hours[0], "hours_availability": hours[1]};
    // }
    // // print(schedule);
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection('fields').get();
    // // Loop through documents
    // querySnapshot.docs.forEach((doc) async {
    //   Map<String, dynamic> newData = {'availability': schedule};

    //   // Update document with the new field
    //   await FirebaseFirestore.instance
    //       .collection('fields')
    //       .doc(doc.id)
    //       .update(newData);
    // });
    super.onInit();
  }

  getFields() async {
    try {
      fields.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString('userID') ?? "";
      await FirebaseFirestore.instance
          .collection('fields')
          .where('supplier_id', isEqualTo: userID)
          .get()
          .then((event) {
        for (var doc in event.docs) {
          var data = doc.data();
          fields.add({'id': doc.id, 'name': data['name']});
        }
      });
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
    }
  }

  getBookings() async {
    upcomingBookings.clear();
    pastBookings.clear();
    List<String> ids = fields.map((map) => map['id'] as String).toList();
    await FirebaseFirestore.instance
        .collection("fieldBookings")
        .where('fieldID', whereIn: ids)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        List times = data['details'].map((str) {
          // Split the string by "@" and take the second part (after "@")
          return str.split('@')[1].trim();
        }).toList();
        String details = times.join(', ');
        var fieldBooking = FieldBooking(
            doc.id,
            data['bookerName'],
            data['date'],
            data['phoneNumber'],
            (data['price']).toInt(),
            details,
            data['fieldID'],
            data['fieldName'],
            data['hoursBooked'],
            data['userID']);
        var formattedDate = DateTime.parse(fieldBooking.date);
        var today = DateTime.now();
        today = DateTime(today.year, today.month, today.day);
        if (formattedDate.isBefore(today)) {
          if (pastBookings.containsKey(fieldBooking.fieldID)) {
            pastBookings[fieldBooking.fieldID]?.add(fieldBooking);
          } else {
            pastBookings[fieldBooking.fieldID] = [fieldBooking];
          }
        } else {
          if (upcomingBookings.containsKey(fieldBooking.fieldID)) {
            upcomingBookings[fieldBooking.fieldID]?.add(fieldBooking);
          } else {
            upcomingBookings[fieldBooking.fieldID] = [fieldBooking];
          }
        }
      }
      upcomingBookings.keys.forEach((key) {
        upcomingBookings[key]?.sort(
            (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      });
      pastBookings.keys.forEach((key) {
        upcomingBookings[key]?.sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
      });
    });
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
