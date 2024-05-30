import 'package:fieldz/views/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/admin_landing_page.dart';
import 'package:fieldz/views/supplier_dashboard_view.dart';
import 'package:fieldz/views/user_landing_page.dart';
import 'package:fieldz/views/coach_landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential.user!.emailVerified) {
        Map userData = {};
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user?.uid)
            .get()
            .then((DocumentSnapshot doc) {
          userData = doc.data() as Map<String, dynamic>;
          userData['id'] = doc.id;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', userData['id']);
        switch (userData['user_type']) {
          case 'user':
            Get.to(() => UserLandingPage());
            break;
          case 'admin':
            Get.to(() => AdminLandingPage());
            break;
          case 'supplier':
            Get.to(() => SupplierDashboardView());
            break;
          case 'coach':
            Get.to(() => const LandingPage());
            break;
          default:
            break;
        }
      } else {
        messageDialog("Account not verified",
            "Your account is not verified. Please verify your account to continue.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        messageDialog("Invalid Credentials",
            "These credentials don't exist. Please check the details and try again.");
      } else if (e.code == 'user-not-found') {
        messageDialog("User Not Found",
            "The user you are looking for does not exist. Please check the details and try again.");
      } else if (e.code == 'wrong-password') {
        messageDialog("Wrong Password",
            "The password you entered is incorrect. Please try again.");
      } else {
        messageDialog("Something Went Wrong", "Please try again.");
      }
    }
  }
}
