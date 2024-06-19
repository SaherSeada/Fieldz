import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/program.dart';
import 'package:fieldz/models/session.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:get/get.dart';

class CoachActivityController extends GetxController {
  final RxList sessions = [].obs;
  final RxList programs = [].obs;

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    await getSessions();
    await getPrograms();
    isLoaded.value = true;
    super.onInit();
  }

  getSessions() async {
    sessions.clear();
    try {
      await FirebaseFirestore.instance
          .collection("sessions")
          .get()
          .then((event) {
        for (var doc in event.docs) {
          var data = doc.data();
          String date = data['date'];
          DateTime parsedDate = DateTime.parse(date);
          DateTime currentDate = DateTime.now();
          DateTime parsedDateOnly =
              DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
          DateTime currentDateOnly =
              DateTime(currentDate.year, currentDate.month, currentDate.day);
          if (parsedDateOnly.isBefore(currentDateOnly)) {
            continue;
          }
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
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
    }
  }

  getPrograms() async {
    programs.clear();
    try {
      await FirebaseFirestore.instance
          .collection("programs")
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
      });
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
    }
  }
}
