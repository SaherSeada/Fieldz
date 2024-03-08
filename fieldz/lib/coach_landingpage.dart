import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



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
          }, icon: Icon(Icons.close))
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
          Container(
            // margin: EdgeInsets.all(5),
              height: 150,
              width: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/coach.png"), // Add your profile image
              ),),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'LEAD WITH INTEGRITY',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Choose your desired color
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'select an option',
            style: TextStyle(fontSize: 25.0, color: Colors.green),
          ),
          SizedBox(height: 16.0),
          // Cards for destination selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DestinationCard(
                text: '  Programs  ',
                onPressed: () {
                },
              ),
              SizedBox(width: 16.0),
              DestinationCard(
                text: '   Athletes   ',
                onPressed: () {
                },
              ),
            ],
          ),
          SizedBox(height: 25.0),
          DestinationCard(
            text: '  Mange Profile  ',
            onPressed: () {
            },
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