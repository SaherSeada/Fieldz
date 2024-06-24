import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/models/coach.dart';
import 'package:get/get.dart';

class AdminCoachesController extends GetxController {
  RxBool isLoaded = false.obs;
  RxList activeCoaches = [].obs;
  RxList pendingCoaches = [].obs;
  RxList rejectedCoaches = [].obs;

  @override
  void onInit() async {
    await getCoaches();
    super.onInit();
  }

  getCoaches() async {
    isLoaded.value = false;
    activeCoaches.clear();
    pendingCoaches.clear();
    rejectedCoaches.clear();
    await FirebaseFirestore.instance.collection("coaches").get().then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        var coach = Coach(
            doc.id,
            data['email'],
            data['username'],
            data['phoneNumber'],
            data['rating'],
            data['avatarURL'],
            data['sport']);
        coach.status = data['status'];
        if (coach.status == 'verified') {
          activeCoaches.add(coach);
        } else if (coach.status == 'pending') {
          pendingCoaches.add(coach);
        } else {
          rejectedCoaches.add(coach);
        }
      }
    });
    isLoaded.value = true;
  }
}
