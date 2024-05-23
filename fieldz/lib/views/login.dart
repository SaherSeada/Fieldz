import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/views/admin_landing_page.dart';
import 'package:fieldz/views/supplier_dashboard_view.dart';
import 'package:fieldz/views/supplier_login.dart';
import 'package:fieldz/views/user_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/views/coach_landing_page.dart';
import 'package:fieldz/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldz/theme/theme_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply theme here
      data: lightTheme,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100), // Adjust spacing from top
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      "Login with email",
                      style: TextStyle(
                          color: COLOR_ACCENT,
                          fontSize: 16), // Apply accent color
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: COLOR_ACCENT), // Apply accent color
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: COLOR_ACCENT, // Apply accent color
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
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
                  child: const Text("Login"),
                ),
                Container(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(() => const SignUp());
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't Have An Account?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "  Register",
                              style: TextStyle(
                                  color: COLOR_ACCENT,
                                  fontWeight:
                                      FontWeight.bold)), // Apply accent color
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => const SupplierLogin());
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "If you're a supplier press",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: " here",
                            style: TextStyle(
                                color: COLOR_ACCENT,
                                fontWeight: FontWeight.bold),
                          ), // Apply accent color
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
