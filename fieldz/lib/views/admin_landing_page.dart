import 'package:fieldz/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_coaches_screen.dart';
import 'admin_fields_screen.dart';

class AdminLandingPage extends StatelessWidget {
  const AdminLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Control Room'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                  height: 100.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text('Menu',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )),
              // ListTile(
              //   title: const Text('My Profile'),
              //   leading: const Icon(Icons.table_view_outlined),
              //   onTap: () {
              //     Get.to(() => UserProfileScreen());
              //   },
              // ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => Login());
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.to(() => AdminCoachesListPage());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/Coaches.png'), // Load from assets
                      const SizedBox(height: 8),
                      const Text('Coaches',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Get.to(() => AdminFieldsPage());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/Fields.png'),
                      const SizedBox(height: 8), // Load from assets
                      const Text('Fields',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
