import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Coach_Activity extends StatefulWidget {
  const Coach_Activity({Key? key}) : super(key: key);

  @override
  State<Coach_Activity> createState() => _Coach_ActivityState();
}

class _Coach_ActivityState extends State<Coach_Activity> {
  String username = ''; // Variable to hold the username
  String email = ''; // Variable to hold the email////////

  List<QueryDocumentSnapshot> sessions = [];
  List<QueryDocumentSnapshot> programs = [];

  getPrograms() async {
    DateTime currentDate = DateTime.now();
    String formattedDate = "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

    print("Current date: $formattedDate");

    QuerySnapshot programSnapshot = await FirebaseFirestore.instance
        .collection("programs")
        .where("Schedule_dates", arrayContains: formattedDate)
        .get();

    print("Programs: ${programSnapshot.docs.length}");

    programs = programSnapshot.docs;
    setState(() {});
  }

  getSession() async {
    DateTime currentDate = DateTime.now();
    String formattedDate = "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

    print("Current date: $formattedDate");

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Sessions").orderBy("date").get();

    print("Sessions: ${querySnapshot.docs.length}");

    sessions = querySnapshot.docs;
    setState(() {});
  }

  @override
  void initState() {
    getPrograms();
    getSession();
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
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  Text(
                    "Activity",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.notifications),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text(
              "  Upcoming Slot Sessions",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            Container(
              height: 290,
              child: sessions.isEmpty
                  ? Center(
                child: Text(
                  'You have no upcoming quick Sessions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sessions.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Session: " "${sessions[i]['Program_name']}",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 5),
                                    Text(
                                      "Location: " "${sessions[i]['location']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    SizedBox(width: 5),
                                    Text(
                                      "Date: " "${sessions[i]['date']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time),
                                    SizedBox(width: 5),
                                    Text(
                                      "Time: " "${sessions[i]['time']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.timer),
                                    SizedBox(height: 5),
                                    Text(
                                      "Duration: " "${sessions[i]['duration']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.attach_money),
                                    SizedBox(height: 5),
                                    Text(
                                      "Price: " "${sessions[i]['Price']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add action for editing the session
                                  },
                                  child: Text(
                                    'Cancel',
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
                                    'Complete',
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
                  );
                },
              ),
            ),
            Text(
              " Upcoming Program Sessions",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            Container(
              height: 210,
              child: programs.isEmpty
                  ? Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No upcoming Program Sessions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: programs.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Program: " "${programs[i]['Program_name']}",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 5),
                                    Text(
                                      "Location: " "${programs[i]['Location']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    SizedBox(width: 5),
                                    Text(
                                      "Date: " "${programs[i]['Schedule_dates']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    SizedBox(width: 5),
                                    Text(
                                      "Time: " "${programs[i]['Schedule_times']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add action for editing the session
                                  },
                                  child: Text(
                                    'cancel',
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
                                    'complete',
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
