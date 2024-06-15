import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/admin_coaches_controller.dart';
import 'package:fieldz/models/coach.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:get/get.dart';

class AdminCoachDetailsController extends GetxController {
  late Coach coach;
  Map? arguments;

  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    coach = arguments?['coach'];
    isLoaded.value = true;
    super.onInit();
  }

  onPressed(String newStatus) async {
    isLoaded.value = false;
    try {
      await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coach.id)
          .update({'status': newStatus});
    } catch (e) {
      isLoaded.value = true;
      messageDialog("Something Went Wrong!", "Please try again.");
      return;
    }
    coach.status = newStatus;
    AdminCoachesController coachesController = Get.find();
    await coachesController.getCoaches();
    isLoaded.value = true;
    snackBar("Coach Status updated successfully");
  }
}
