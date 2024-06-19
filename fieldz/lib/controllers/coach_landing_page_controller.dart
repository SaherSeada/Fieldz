import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachLandingPageController extends GetxController {
  RxString username = "".obs;
  RxString email = "".obs;

  @override
  void onInit() async {
    print(DateTime.now());
    await fetchUserDetails();
    super.onInit();
  }

  fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID') ?? "";

    if (userID != "") {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .get();

        if (userSnapshot.exists) {
          username.value = userSnapshot['username'];
          email.value = userSnapshot['email'];
        }
      } catch (e) {
        messageDialog("Something Went Wrong!", "Please try again.");
      }
    }
  }
}
