import 'package:fieldz/controllers/main_controller.dart';
import 'package:fieldz/views/admin_landing_page.dart';
import 'package:fieldz/views/coach_landingpage.dart';
import 'package:fieldz/views/login.dart';
import 'package:fieldz/views/supplier_login.dart';
import 'package:fieldz/views/user_landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fieldz/theme/theme_constants.dart';
import 'package:fieldz/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fieldz',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mainController.user.value == null) {
        // User is not signed in, navigate to login page
        return const Login();
      } else {
        // User is signed in, navigate to home page
        switch (mainController.userType.value) {
          case 'user':
            return UserLandingPage();
          case 'admin':
            return AdminLandingPage();
          case 'supplier':
            return const SupplierLogin();
          case 'coach':
            return const LandingPage();
          default:
            return const Login();
        }
      }
    });
  }
}
