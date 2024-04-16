import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Coach_Profile extends StatefulWidget {
  const Coach_Profile({super.key});

  @override
  State<Coach_Profile> createState() => _Coach_ProfileState();
}

class _Coach_ProfileState extends State<Coach_Profile> {
  String username = ''; // Variable to hold the username
  String email = ''; // Variable to hold the email


  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch the username when the widget initializes
  }

  Future<void> fetchUsername() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      // User is signed in, get the username from Firestore
      try {
        DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          // If the user document exists, get the username
          setState(() {
            username = userSnapshot['username'];
            email = userSnapshot['email'];
          });
        }
      } catch (e) {
        print('Error fetching username: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  Text("Activity",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.notifications),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text("Upcoming Sessions",style: TextStyle(
                fontSize: 20,
                color: Colors.orange
            ),
            ),
      Card(
        elevation: 10,
        child:Container(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0.0),
                child: Card(
                  elevation: 4, // Controls the shadow depth
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Defines the border radius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Session Name: Cardio Workout', // Session name
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Location: Gym XYZ', // Location
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Date: April 20, 2024', // Date
                            ),
                            Text(
                              'Time: 8:00 AM - 9:00 AM', // Time
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Duration: 1 hour', // Duration
                            ),
                            Text(
                              'Price: \$20', // Price
                            ),
                          ],
                        ),
                      ),
                      // Divider for visual separation
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Add action for editing the session
                              },
                              child: Text(
                                'Edit', // Edit button
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                // Add action for deleting the session
                              },
                              child: Text(
                                'Delete', // Delete button
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0.0),
                child: Card(
                  elevation: 4, // Controls the shadow depth
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Defines the border radius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Session Name: Cardio Workout', // Session name
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Location: Gym XYZ', // Location
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Date: April 20, 2024', // Date
                            ),
                            Text(
                              'Time: 8:00 AM - 9:00 AM', // Time
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Duration: 1 hour', // Duration
                            ),
                            Text(
                              'Price: \$20', // Price
                            ),
                          ],
                        ),
                      ),
                      // Divider for visual separation
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Add action for editing the session
                              },
                              child: Text(
                                'Edit', // Edit button
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                // Add action for deleting the session
                              },
                              child: Text(
                                'Delete', // Delete button
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )




      ],
        ),
      ),
    );
  }
}
