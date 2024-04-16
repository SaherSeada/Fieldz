import 'package:get/get.dart';

class FieldBookingController extends GetxController {
  Map? arguments;
  String? title;
  Map? availability;
  String? selectedDate;
  RxList currentHours = [].obs;
  RxList hoursAvailability = [].obs;
  final List<RxBool> selectedHours = [];
  RxString startTime = "".obs;
  RxString endTime = "".obs;
  
  @override
  void onInit() {
    arguments = Get.arguments;
    title = arguments?['field_name'];
    availability = arguments?['availability'];
    selectedDate = arguments?['selected_day'];
    List hoursList = availability?[selectedDate].keys.toList();
    hoursList.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    currentHours.addAll(hoursList);
    for (var hour in currentHours) {
      selectedHours.add(false.obs);
      hoursAvailability.add(availability?[selectedDate][hour]);
    }
    super.onInit();
  }

  checkSelectedHours() {
    startTime.value = "";
    endTime.value = "";
    String temp = "";
    for (int i = 0; i < selectedHours.length; i++) {
      if (selectedHours[i].value) {
        if (startTime.value == "") {
          startTime.value = currentHours[i];
        }
        else {
          temp = currentHours[i];
        }
      }
    }
    endTime.value = (int.parse(temp) + 1).toString();
  }
}