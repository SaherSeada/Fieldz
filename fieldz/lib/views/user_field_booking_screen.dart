import 'package:fieldz/controllers/user_field_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldBookingScreen extends StatelessWidget {
  FieldBookingScreen({super.key});

  final FieldBookingController controller = Get.put(FieldBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.title ?? ""),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoaded.value ? Stack(children: [
              GridView.builder(
                itemCount: controller.currentHours.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1.5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridTile(
                        child: Obx(() => TextButton(
                              onPressed: controller.hoursAvailability[index]
                                  ? () {
                                      controller.selectedHours[index].value =
                                          controller.selectedHours[index].value
                                              ? false
                                              : true;
                                      controller.checkSelectedHours();
                                    }
                                  : null,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    !controller.hoursAvailability[index]
                                        ? Colors.red
                                        : controller.selectedHours[index].value
                                            ? Colors.green
                                            : Colors.blue,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  )),
                              child: Text(
                                "${controller.currentHours[index]}:00",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ))),
                  );
                },
              ),
              Obx(() => controller.bookingDetails.isNotEmpty ? Positioned(
                  bottom: 5,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: Get.width,
                      height: 175.0 + 19 * controller.bookingDetails.length,
                      child: Card(
                          color: Colors.grey.shade200,
                          elevation: 5,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                const Text("Booking",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const SizedBox(height: 15),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: controller.bookingDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                        controller.bookingDetails[index],
                                        style: const TextStyle(fontSize: 16));
                                  },
                                )),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Column(
                                        children: [
                                          const Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                          Text("${controller.numberOfSelectedHours.value * controller.price!}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                                        ],
                                      )),
                                      ElevatedButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blueAccent)),
                                      child: const Text("Confirm Booking"),
                                      onPressed: () {
                                        controller.confirmBooking();
                                      },
                                    )]))
                              ]))))) : const SizedBox())
            ]) : const Center(child: CircularProgressIndicator())));
  }
}
