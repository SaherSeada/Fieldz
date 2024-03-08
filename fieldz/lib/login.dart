import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldz/LandingPage.dart';
import 'package:fieldz/coach_landingpage.dart';
import 'package:fieldz/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    // margin: EdgeInsets.all(5),
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(color: Colors.white),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/coach.png"), // Add your profile image
                      )),
                ),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Login with email",
                  style: TextStyle(color: Colors.amber),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
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
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText:true,
                  decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: ()async{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.amber,
              textColor: Colors.white,
              onPressed: () async{
                // Get.to(() => AdminLandingPage());
                try {
                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if(credential.user!.emailVerified){
                    Get.to(() => LandingPage());
                    print('email is  validated');
                  } else{
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      title: 'verification',
                      desc:
                      'verify your email account',
                    )..show();
                  }
                } on FirebaseAuthException catch (e) {
                  print('here');
                  print(e);
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');

                  }
                }

              },
              child: Text("Login"),
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Get.to(() => SignUp());
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Don't Have An Account ?",
                  ),
                  TextSpan(
                      text: " Register",
                      style:TextStyle(
                          color: Colors.amber
                      )
                  )
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}