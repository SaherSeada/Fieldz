import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);
  Rx<String?> userType = (null as String?).obs;

  @override
  void onInit() async {
    // Listen for changes in authentication state
    user.value = FirebaseAuth.instance.currentUser;
    if (user.value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userID', user.value!.uid);
      Map userData = {};
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.value?.uid)
          .get()
          .then((DocumentSnapshot doc) {
        userData = doc.data() as Map<String, dynamic>;
      });
      userType.value = userData['user_type'];
    }
    super.onInit();
  }
}
