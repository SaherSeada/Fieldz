import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldz/controllers/user_fields_controller.dart';
import 'package:fieldz/views/user_bookings_screen.dart';
import 'package:fieldz/views/widgets/dialog.dart';
import 'package:fieldz/views/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FieldBookingController extends GetxController {
  Map? arguments;
  String? title;
  Map? availability;
  int? price;
  String? selectedDate;
  RxList currentHours = [].obs;
  RxList hoursAvailability = [].obs;
  final List<RxBool> selectedHours = [];
  final RxInt numberOfSelectedHours = 0.obs;
  RxList bookingDetails = [].obs;

  RxBool isLoaded = false.obs;

  final FieldsController fieldsController = Get.find();

  @override
  void onInit() {
    arguments = Get.arguments;
    title = arguments?['field_name'];
    availability = arguments?['availability'];
    price = arguments?['price'];
    selectedDate = arguments?['selected_day'];
    List hoursList = availability?[selectedDate]["hours"];
    currentHours.addAll(hoursList);
    hoursAvailability.addAll(availability?[selectedDate]["hours_availability"]);
    for (int i = 0; i < currentHours.length; i++) {
      selectedHours.add(false.obs);
    }
    isLoaded.value = true;
    super.onInit();
  }

  checkSelectedHours() {
    numberOfSelectedHours.value = 0;
    bool foundStartTime = false;
    String bookingTime = "";
    bookingDetails.clear();
    for (int i = 0; i < selectedHours.length; i++) {
      if (selectedHours[i].value) {
        numberOfSelectedHours.value++;
      }
      if (!foundStartTime && selectedHours[i].value) {
        foundStartTime = true;
        DateTime date = DateTime.parse(selectedDate ?? "");
        String formattedDate = DateFormat('E, dd MMM').format(date);
        bookingTime = "$formattedDate @ ${currentHours[i]}:00 - ";
      }
      if (foundStartTime) {
        if (!selectedHours[i].value) {
          bookingTime += "${currentHours[i]}:00";
          bookingDetails.add(bookingTime);
          foundStartTime = false;
        } else if (i == selectedHours.length - 1) {
          int hour = (int.parse(currentHours[i]) + 1) % 24;
          bookingTime += "${hour.toString().padLeft(2, '0')}:00";
          bookingDetails.add(bookingTime);
        }
      }
    }
  }

  confirmBooking() async {
    try {
      isLoaded.value = false;
      for (int i = 0; i < selectedHours.length; i++) {
        if (selectedHours[i].value) {
          hoursAvailability[i] = false;
        }
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? "";
      String phoneNumber = prefs.getString('phoneNumber') ?? "";
      String userID = prefs.getString('userID') ?? "";
      List<bool> boolSelectedHours =
          selectedHours.map((rxBool) => rxBool.value).toList();
      await FirebaseFirestore.instance.collection('fieldBookings').add({
        'bookerName': username,
        'phoneNumber': phoneNumber,
        'userID': userID,
        'price': numberOfSelectedHours.value * price!,
        'details': bookingDetails,
        'date': selectedDate,
        'hoursBooked': boolSelectedHours,
        'fieldID': arguments?['id'],
        'fieldName': title,
      });
      await FirebaseFirestore.instance
          .collection('fields')
          .doc(arguments?['id'])
          .update({
        'availability.$selectedDate.hours_availability': hoursAvailability
      });
      fieldsController.getFields();
      isLoaded.value = true;
      Get.off(UserBookingsScreen());
      snackBar("Booking Completed Successfully");
      return true;
    } catch (e) {
      messageDialog("Something Went Wrong!", "Please try again.");
    }
  }
}
