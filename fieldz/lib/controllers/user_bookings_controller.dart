import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/coach_booking.dart';
import 'package:fieldz/models/field_booking.dart';
import 'package:fieldz/models/program.dart';
import 'package:fieldz/models/session.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBookingsController extends GetxController {
  RxList fieldBookings = [].obs;
  RxList coachBookings = [].obs;

  List sessionIDs = [];
  List programIDs = [];

  RxList sessions = [].obs;
  RxList programs = [].obs;

  RxBool isLoaded = false.obs;

  late String userID;

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? "";
    await getFieldBookings();
    await getCoachBookings();
    super.onInit();
  }

  getFieldBookings() async {
    fieldBookings.clear();
    await FirebaseFirestore.instance
        .collection("fieldBookings")
        .where('userID', isEqualTo: userID)
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
        fieldBookings.add(fieldBooking);
      }
      fieldBookings.sort(
          (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
    });
  }

  getCoachBookings() async {
    coachBookings.clear();
    sessionIDs.clear();
    programIDs.clear();
    await FirebaseFirestore.instance
        .collection("coachBookings")
        .where('userID', isEqualTo: userID)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        var coachBooking = CoachBooking(
            doc.id,
            data['bookerName'],
            data['phoneNumber'],
            (data['price']).toInt(),
            data['type'],
            data['bookedID'],
            data['userID']);
        coachBookings.add(coachBooking);
        if (coachBooking.type == 'sessions') {
          sessionIDs.add(coachBooking.bookedID);
        } else {
          programIDs.add(coachBooking.bookedID);
        }
      }
    });
    if (sessionIDs.isNotEmpty) {
      sessions.clear();
      await FirebaseFirestore.instance
          .collection("sessions")
          .where(FieldPath.documentId, whereIn: sessionIDs)
          .get()
          .then((event) {
        for (var doc in event.docs) {
          var data = doc.data();
          var session = Session(
              doc.id,
              data['coachID'],
              data['name'],
              data['description'],
              data['location'],
              (data['duration']).toDouble(),
              data['price'].toDouble(),
              data['capacity'].toInt(),
              data['users'] ?? [],
              data['date'],
              data['time'],
              data['available']);
          sessions.add(session);
        }
      });
    }
    if (programIDs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("programs")
          .where(FieldPath.documentId, whereIn: programIDs)
          .get()
          .then((event) {
        for (var doc in event.docs) {
          var data = doc.data();
          var program = Program(
              doc.id,
              data['coachID'],
              data['name'],
              data['description'],
              data['location'],
              (data['duration']).toDouble(),
              data['price'].toDouble(),
              data['capacity'].toInt(),
              data['users'] ?? [],
              data['schedule'],
              data['available']);
          programs.add(program);
        }
        print(programs);
      });
    }
  }
}
