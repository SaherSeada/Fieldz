import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierProfileController extends GetxController {
  late String userID;
  RxBool isLoaded = false.obs;
  RxBool enableEdit = false.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? "";
    await getUserDetails();
    isLoaded.value = true;
    super.onInit();
  }

  getUserDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        usernameController.text = data['username'];
        emailController.text = data['email'];
        phoneController.text = data['phoneNumber'];
        avatarController.text = data['avatarURL'];
      } else {
        return null;
      }
    } catch (e) {
      messageDialog("Something Went Wrong", "Please try again.");
    }
  }

  refreshDetails() async {
    isLoaded.value = false;
    getUserDetails();
    isLoaded.value = true;
  }

  updateDetails() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'username': usernameController.text,
        'email': emailController.text,
        'phoneNumber': phoneController.text,
        'avatarURL': avatarController.text,
      });
      snackBar("Details Updated Successfully");
      enableEdit.value = false;
      refreshDetails();
    } catch (e) {
      messageDialog("Something Went Wrong", "Please try again.");
    }
  }
}
