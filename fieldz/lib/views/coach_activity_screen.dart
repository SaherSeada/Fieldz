import 'package:fieldz/controllers/coach_activity_controller.dart';
import 'package:fieldz/views/coach_edit_plan_page.dart';
import 'package:fieldz/views/coach_edit_session_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoachActivityScreen extends StatelessWidget {
  CoachActivityScreen({Key? key}) : super(key: key);

  final CoachActivityController controller = Get.put(CoachActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Column(children: [
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Activity",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Icon(Icons.notifications),
            ],
          ),
        ])),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.refreshData();
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const Text(
                  "Upcoming Quick Sessions",
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 290,
                  child: Obx(() => controller.sessions.isEmpty
                      ? const Center(
                          child: Text(
                            'You have no upcoming quick Sessions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.sessions.length,
                          itemBuilder: (context, i) {
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CoachEditSessionsPage(),
                                        arguments: {
                                          'session': controller.sessions[i]
                                        });
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.sessions[i].name,
                                                style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Location: "
                                                    "${controller.sessions[i].location}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.date_range),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Date: "
                                                    "${controller.sessions[i].date}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Time: "
                                                    "${controller.sessions[i].time}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.timer),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Duration: "
                                                    "${controller.sessions[i].duration.toInt()} Hour${controller.sessions[i].duration > 1 ? "s" : ""}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.attach_money),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Price: "
                                                    "${controller.sessions[i].price} EGP",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.group),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    'Participants: ${controller.sessions[i].users.length}/${controller.sessions[i].capacity}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        )),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Active Subscription Plans",
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 380,
                  child: Obx(() => controller.programs.isEmpty
                      ? Center(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'No upcoming Program Sessions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.programs.length,
                          itemBuilder: (context, i) {
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        () => CoachEditSubscriptionPlanPage(),
                                        arguments: {
                                          'program': controller.programs[i]
                                        });
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.programs[i].name,
                                                style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Location: "
                                                    "${controller.programs[i].location}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.timer),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Session Duration: "
                                                    "${controller.programs[i].duration.toInt()} Hour${controller.programs[i].duration > 1 ? "s" : ""}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.attach_money),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Price: "
                                                    "${controller.programs[i].price} EGP/Month",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(Icons.group),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    'Participants: ${controller.programs[i].users.length}/${controller.programs[i].capacity}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Row(
                                                children: [
                                                  Icon(Icons.date_range),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Schedule: ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              ...controller
                                                  .programs[i].schedule.entries
                                                  .map((entry) {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 2,
                                                        horizontal: 10),
                                                    child: Text(
                                                      '${entry.key}: ${entry.value} - ${addHoursToTime(entry.value, controller.programs[i].duration.toInt())}',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ));
                                              }).toList(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        )),
                ),
              ],
            ),
          ),
        ));
  }

  String addHoursToTime(String time, int hoursToAdd) {
    // Define the input and output format
    final DateFormat inputFormat = DateFormat.jm();
    final DateFormat outputFormat = DateFormat.jm();

    // Parse the input time string to a DateTime object
    DateTime dateTime = inputFormat.parse(time);

    // Add the specified number of hours
    dateTime = dateTime.add(Duration(hours: hoursToAdd));

    // Format the resulting DateTime object back to the desired string format
    String result = outputFormat.format(dateTime);

    return result;
  }
}
