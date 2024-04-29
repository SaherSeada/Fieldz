import 'package:fieldz/models/supplier_court_model.dart';
import 'package:get/get.dart';

class AddCourtController extends GetxController {
  List<String> sports = ["Football", "Padel", "Tennis", "Basketball", "Handball", "Hockey"];
  Rx<String?> selectedSport = null.obs;
  
  void submitForm() {
  }
}
