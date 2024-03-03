import 'package:fieldz/models/field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FieldsController extends GetxController {
  final List fields = [
    Field("Manor House School", "Tagammoa 5, New Cairo", "300", "4",
        "https://placehold.co/500x200/png"),
    Field("Manor House School", "Tagammoa 5, New Cairo", "300", "3",
        "https://placehold.co/500x200/png"),
    Field("Manor House School", "Tagammoa 5, New Cairo", "300", "2",
        "https://placehold.co/500x200/png")
  ];
  final List days = [];
  RxInt selectedFilterIndex = 0.obs;

  @override
  void onInit() {
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(currentDate);
      days.add(dayName);
    }
    super.onInit();
  }
}
