import 'package:fieldz/controllers/login_controller.dart';
import 'package:fieldz/views/supplier_login.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fieldz/theme/theme_constants.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Theme(
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
                Form(
                    key: controller.formKey,
                    child: Column(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter an Email";
                            }
                            return null;
                          },
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a Password";
                            }
                            return null;
                          },
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
                                email: controller.emailController.text);
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
                    )),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: COLOR_ACCENT, // Apply accent color
                  textColor: Colors.white,
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      controller.login();
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
