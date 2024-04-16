import 'coach_landingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the login screen
      if(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );} else {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Login()),);

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Embrace The Journey',
              style: TextStyle(
                color: Color(0xFF38882F),
                fontSize: 34.0,
              ),
            ),
            SizedBox(height: 61.0),
            Text(
              'Fieldz',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 54.0),
            Text(
              'Developed by Akram',
              style: TextStyle(
                color: Color(0xFFE6BD81),
              ),
            ),
          ],
        ),
      ),
    );
  }
}