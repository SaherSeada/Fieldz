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
        body: Obx(() => Stack(children: [
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
              Obx(() => Positioned(
                  bottom: 5,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: Get.width,
                      height: Get.height / 3,
                      child: Card(
                          color: Colors.grey.shade200,
                          elevation: 5,
                          child: Padding(padding: const EdgeInsets.all(8), child: Column(children: [
                            const Text("Booking", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 15),
                            Text("${controller.selectedDate} @ ${controller.startTime.value}:00 - ${controller.endTime.value}:00", style: TextStyle(fontSize: 14))
                          ]))))))
            ])));
  }
}
