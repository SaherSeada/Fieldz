import 'package:fieldz/controllers/coach_landing_page_controller.dart';
import 'package:fieldz/views/coach_sessions_page.dart';
import 'package:fieldz/views/coach_subscription_plan_screen.dart';
import 'package:fieldz/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'coach_activity_screen.dart';

class CoachLandingPage extends StatelessWidget {
  CoachLandingPage({super.key});

  final CoachLandingPageController controller =
      Get.put(CoachLandingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text(controller.username.value)),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Obx(() => Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(controller.avatarURL.value),
                        ),
                      ),
                      Expanded(
                          child: ListTile(
                        title: Text(controller.username.value),
                        subtitle: Text(controller.email.value),
                      ))
                    ],
                  )),
              ListTile(
                title: const Text("Profile"),
                leading: const Icon(Icons.person),
                onTap: () {},
              ),
              ListTile(
                title: const Text("History"),
                leading: const Icon(Icons.help),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Feedback"),
                leading: const Icon(Icons.check),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Sign Out"),
                leading: const Icon(Icons.exit_to_app_rounded),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => Login());
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Obx(() => Container(
                // margin: EdgeInsets.all(5),
                height: 180,
                width: 300,
                decoration: const BoxDecoration(color: Colors.white),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      controller.avatarURL.value), // Add your profile image
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Select an Option',
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          const SizedBox(height: 30.0),
          const NavigationBar(),
          const SizedBox(height: 80.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Fieldz, Lead With Integrity',
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold // Choose your desired color
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
            child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(35), // Adjust the value as needed
              color: Colors.blueGrey,
            ),
            child: SizedBox(
              height: 50,
              width: 380, // Occupy the full width of the screen
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => CoachSessionsPage());
                    },
                    child: const Text("Quick Sessions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Container(
                    width: 5,
                    color: Colors.amber,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => CoachSubscriptionPlanPage());
                    },
                    child: const Text("Subscription Plans",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(35), // Adjust the value as needed
                color: Colors.orangeAccent,
              ),
              width: 250,
              child: MaterialButton(
                  onPressed: () {
                    Get.to(() => CoachActivityScreen());
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 10),
                        Text("Your Activities",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ])))
        ])));
  }
}
