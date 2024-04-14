import 'package:fieldz/controllers/user_landing_page_controller.dart';
import 'package:fieldz/views/user_coaches_screen.dart';
import 'package:fieldz/views/user_fields_screen.dart';
import 'package:fieldz/views/user_marketplace_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLandingPage extends StatelessWidget {
  UserLandingPage({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                onTap: landingPageController.changeTabIndex,
                currentIndex: landingPageController.tabIndex.value,
                backgroundColor: const Color.fromARGB(255, 37, 120, 157),
                unselectedItemColor: Colors.white.withOpacity(0.5),
                selectedItemColor: Colors.white,
                unselectedLabelStyle: unselectedLabelStyle,
                selectedLabelStyle: selectedLabelStyle,
                type: BottomNavigationBarType.fixed,
                items: landingPageController.bottomNavigationBarItemList,
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              FieldsScreen(),
              CoachesScreen(),
              UserMarketplaceScreen()
            ],
          )),
    ));
  }
}