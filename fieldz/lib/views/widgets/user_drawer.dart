import 'package:fieldz/views/login.dart';
import 'package:fieldz/views/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

userDrawer() {
  return Drawer(
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
        ListTile(
          title: const Text('My Profile'),
          leading: const Icon(Icons.table_view_outlined),
          onTap: () {
            Get.to(() => UserProfileScreen());
          },
        ),
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
  );
}
