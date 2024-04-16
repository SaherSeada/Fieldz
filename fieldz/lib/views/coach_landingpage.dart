import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Coach_Profile.dart';
import 'Coach_Programs.dart';



class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();

}

class _LandingPageState extends State<LandingPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          }, icon: Icon(Icons.notifications))
        ] ,
        centerTitle: true,
        title: Text(username),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.all(15),
          child: ListView(children: [
            Row(children: [
              Container(
                width: 60,
                height:60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/Profile.png"), // Add your profile image
                ),
              ),
              Expanded(child: ListTile(
                title: Text(username),
                subtitle: Text(email),
              ))
            ],
            ),
            ListTile(
              title: Text("Homepage"),
              leading:Icon(Icons.home),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
              },
            ),
            ListTile(
              title: Text("Payment"),
              leading:Icon(Icons.account_balance),
              onTap: (){},
            ),
            ListTile(
              title: Text("History"),
              leading:Icon(Icons.help),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil("ridehistory", (route) => false);

              },
            ),
            ListTile(
              title: Text("Feedback"),
              leading:Icon(Icons.check),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil("ridestatus", (route) => false);

              },
            ),
            ListTile(
              title: Text("Sign Out"),
              leading:Icon(Icons.exit_to_app_rounded),
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
              },
            ),
          ],
          ),
        ),
      ), // Set the app bar to null to remove it
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            // margin: EdgeInsets.all(5),
              height: 120,
              width: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: CircleAvatar(
                backgroundImage: AssetImage("images/coach.png"), // Add your profile image
              ),),
          SizedBox(
            height: 30,
          ),
          SizedBox(height: 15.0),
          Text(
            'select an option',
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          SizedBox(height: 30.0),
          // Cards for destination selection
          NavigationBar(),
          SizedBox(height: 80.0),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'In fieldz lead with integrity',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.amber, // Choose your desired color
              ),
            ),
          ),
        ],

      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DestinationCard({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.grey, // Set the background color to grey
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35), // Adjust the value as needed
          color: Colors.blueGrey,
        ),
        child: Container(
          height: 50,
          width: 380, // Occupy the full width of the screen
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Coach_Programs()),
                );
              },
                child: Text("Programs"),
              ),
              Container(
                width: 5,
                color: Colors.amber,
              ),
              MaterialButton(onPressed: (){
              },

                child: Text("Atheletes"),
              ),
              Container(
                width: 5,
                color: Colors.amber,
              ),
              MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Coach_Profile()),
                );
              },

                child: Text("My Profile"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}