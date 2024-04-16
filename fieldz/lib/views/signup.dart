import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
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
                        backgroundImage: AssetImage("images/coach.png"), // Add your profile image
                      )),
                ),
                Text(
                  "Sign UP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Sign up with email",
                  style: TextStyle(color: Colors.amber),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Enter Your Username",
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
                  obscureText:true,
                  controller: _passwordController,
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
                Container(
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
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(credential.user?.uid)
                      .set({
                    'username': _usernameController.text,
                    'email': _emailController.text,
                    // Add other user data fields as needed
                  });

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Sign up verification',
                    desc:
                    'check your email account',
                  )..show();
                  await Future.delayed(Duration(seconds: 5));
                  await credential.user?.sendEmailVerification();
                  Navigator.of(context).pushReplacementNamed("login");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      title: 'Sign up error',
                      desc:
                      'The password provided is too weak',
                    )..show();
                  } else if (e.code == 'email-already-in-use') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      title: 'Sign up error',
                      desc:
                      'email-already-in-use',
                    )..show();
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Sign Up"),
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pushReplacementNamed("login");
              },

              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Have An Account ?",
                  ),
                  TextSpan(
                      text: " Login",
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
