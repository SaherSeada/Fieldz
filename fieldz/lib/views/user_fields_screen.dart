import 'package:fieldz/controllers/fields_controller.dart';
import 'package:fieldz/controllers/user_drawer_controller.dart';
import 'package:fieldz/views/user_field_booking_screen.dart';
import 'package:fieldz/views/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsScreen extends StatelessWidget {
  FieldsScreen({super.key});

  final FieldsController controller = Get.put(FieldsController());

  final UserDrawerController drawerController = UserDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: drawerController.scaffoldKey,
        appBar: AppBar(
            title: const Text("Fields",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                drawerController.openDrawer(); // This line opens the drawer
              },
            ),
            toolbarHeight: 60,
            backgroundColor: Colors.blueAccent,
            automaticallyImplyLeading: false),
        drawer: userDrawer(),
        body: Obx(() => controller.isLoaded.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.getFields();
                },
                child: Column(
                  children: [
                    Container(
                      height: 55.0,
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 7),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.days.length,
                        itemBuilder: (context, dayIndex) {
                          return Obx(() => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: TextButton(
                                  onPressed: () {
                                    controller.selectedFilterIndex.value =
                                        dayIndex;
                                    controller.getFieldsByDay();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        dayIndex ==
                                                controller
                                                    .selectedFilterIndex.value
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      )),
                                  child: Text(
                                    controller.days[dayIndex]['dayName'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    Expanded(
                        child: Obx(
                      () => ListView.builder(
                        itemCount: controller.fields.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 250,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 4),
                                  child: Card(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(children: [
                                          Expanded(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    controller
                                                        .fields[index].imageUrl,
                                                    fit: BoxFit.fill,
                                                  ))),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 10, 5, 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .fields[index].name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${controller.fields[index].price} EGP/hour",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .blueAccent),
                                                    )
                                                  ])),
                                          const SizedBox(height: 8),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(children: [
                                                        const SizedBox(
                                                            width: 7),
                                                        const Icon(
                                                          Icons.room,
                                                          size: 15,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          controller
                                                              .fields[index]
                                                              .location,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ]),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  5, 10, 5, 0),
                                                          child: Row(
                                                            children:
                                                                List.generate(5,
                                                                    (i) {
                                                              if (i <
                                                                  controller
                                                                      .fields[
                                                                          index]
                                                                      .rating) {
                                                                return const Icon(
                                                                    Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .yellow);
                                                              } else {
                                                                return const Icon(
                                                                    Icons
                                                                        .star_border,
                                                                    size: 16);
                                                              }
                                                            }),
                                                          ))
                                                    ]),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Get.to(
                                                            () =>
                                                                FieldBookingScreen(),
                                                            arguments: {
                                                              'field_name':
                                                                  controller
                                                                      .fields[
                                                                          index]
                                                                      .name,
                                                              "availability":
                                                                  controller
                                                                      .fields[
                                                                          index]
                                                                      .availability,
                                                              "price": controller.fields[index].price,
                                                              "id": controller.fields[index].id,
                                                              "selected_day": controller
                                                                      .days[
                                                                  controller
                                                                      .selectedFilterIndex
                                                                      .value]['date']
                                                            });
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blueAccent),
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all<Size>(
                                                                      const Size(
                                                                          40,
                                                                          35))),
                                                      child: const Text("Book",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white)),
                                                    ))
                                              ])
                                        ])),
                                  )));
                        },
                      ),
                    ))
                  ],
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
