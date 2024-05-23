import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldz/theme/theme_constants.dart';
import 'package:fieldz/views/signup.dart';
import 'package:fieldz/views/supplier/supplier_dashboard_view.dart';
import 'package:fieldz/views/user_fields_screen.dart';

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
              // ... rest of the UI elements ...

              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: COLOR_ACCENT,
                textColor: Colors.white,
                onPressed: () async {
                  // **Authentication code commented out:**
                  /*
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    // ... rest of the authentication code ...
                  } on FirebaseAuthException catch (e) {
                    // ... error handling ...
                  }
                  */

                  // **Bypass authentication for testing:**
                  Get.to(() =>
                      SupplierDashboardView()); // Navigate directly to SupplierDashboardView
                },
                child: Text("Login"),
              ),
              // ... rest of the UI elements ...
            ],
          ),
        ),
      ),
    );
  }
}
