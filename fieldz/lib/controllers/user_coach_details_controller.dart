import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/user_bookings_controller.dart';
import 'package:fieldz/models/coach.dart';
import 'package:fieldz/models/program.dart';
import 'package:fieldz/models/session.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCoachDetailsController extends GetxController {
  Map? arguments;
  late Coach coach;

  RxList sessions = [].obs;
  RxList programs = [].obs;

  RxBool isLoaded = false.obs;

  late String userID;

  @override
  void onInit() async {
    arguments = Get.arguments;
    coach = arguments?['coach'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? "";
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
          .where('coachID', isEqualTo: coach.id)
          .where('available', isEqualTo: true)
          .where('status', isEqualTo: 'active')
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
              data['duration'],
              data['price'],
              data['capacity'],
              data['users'],
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
          .where('coachID', isEqualTo: coach.id)
          .where('available', isEqualTo: true)
          .where('status', isEqualTo: "active")
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
              data['duration'],
              data['price'],
              data['capacity'],
              data['users'],
              data['schedule'],
              data['available']);
          programs.add(program);
        }
      });
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
    }
  }

  book(int index, String collection) async {
    try {
      List users;
      int capacity;
      String id;
      double price;
      if (collection == 'sessions') {
        users = sessions[index].users;
        capacity = sessions[index].capacity;
        id = sessions[index].id;
        price = sessions[index].price;
      } else {
        users = programs[index].users;
        capacity = programs[index].capacity;
        id = programs[index].id;
        price = programs[index].price;
      }
      users.add(userID);
      bool available = true;
      if (users.length == capacity) {
        available = false;
      }
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .update({'users': users, 'available': available});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? "";
      String phoneNumber = prefs.getString('phoneNumber') ?? "";
      await FirebaseFirestore.instance.collection('coachBookings').add({
        'bookerName': username,
        'phoneNumber': phoneNumber,
        'userID': userID,
        'price': price,
        'type': collection,
        'bookedID': id,
      });
      snackBar(collection == "sessions"
          ? "Session Booked Successfully"
          : "Subscribed Successfully");
      return true;
    } catch (e) {
      print(e);
      messageDialog("Something Went Wrong", "Please try again.");
    }
  }
}
