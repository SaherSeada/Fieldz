import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/views/admin_landing_page.dart';
import 'package:fieldz/views/coach_landingpage.dart';
import 'package:fieldz/views/signup.dart';
import 'package:fieldz/views/user_fields_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldz/theme/theme_constants.dart';

class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key});

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: lightTheme,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(color: Colors.white),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/coach.png"),
                      ),
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    "Login with email",
                    style: TextStyle(color: COLOR_ACCENT), // Apply accent color
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text);
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: COLOR_ACCENT), // Apply accent color
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: COLOR_ACCENT, // Apply accent color
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (credential.user!.emailVerified) {
                      Map userData = {};
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(credential.user?.uid)
                          .get()
                          .then((DocumentSnapshot doc) {
                        userData = doc.data() as Map<String, dynamic>;
                      });
                      switch (userData['user_type']) {
                        case 'user':
                          Get.to(() => FieldsScreen());
                          break;
                        case 'admin':
                          Get.to(() => AdminLandingPage());
                          break;
                        case 'supplier':
                          // Redirect to Supplier Dashboard or Supplier Home page
                          break;
                        case 'coach':
                          Get.to(() => LandingPage());
                          break;
                        default:
                          break;
                      }
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.bottomSlide,
                        title: 'verification',
                        desc: 'verify your email account',
                      )..show();
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      // print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      // print('Wrong password provided for that user.');
                    }
                  }
                },
                child: Text("Login"),
              ),
              Container(height: 20),
              InkWell(
                onTap: () {
                  Get.to(() => SignUp());
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Don't Have An Account ?"),
                        TextSpan(
                            text: " Register",
                            style: TextStyle(
                                color: COLOR_ACCENT)), // Apply accent color
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
