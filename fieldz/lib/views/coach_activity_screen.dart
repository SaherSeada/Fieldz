import 'package:fieldz/controllers/coach_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachActivityScreen extends StatelessWidget {
  CoachActivityScreen({Key? key}) : super(key: key);

  final CoachActivityController controller = Get.put(CoachActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Row(
              children: [
                Text(
                  "Activity",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Icon(Icons.notifications),
              ],
            ),
            const SizedBox(height: 8),
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
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Location: "
                                            "${controller.sessions[i].location}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.date_range),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Date: "
                                            "${controller.sessions[i].date}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Time: "
                                            "${controller.sessions[i].time}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.timer),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Duration: "
                                            "${controller.sessions[i].duration}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.attach_money),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Price: "
                                            "${controller.sessions[i].price}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          // Add action for editing the session
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      TextButton(
                                        onPressed: () {
                                          // Add action for deleting the session
                                        },
                                        child: const Text(
                                          'Complete',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
            ),
            const SizedBox(height: 10),
            const Text(
              "Upcoming Program Sessions",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 210,
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
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
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
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Location: "
                                            "${controller.programs[i].location}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      // Row(
                                      //   children: [
                                      //     const Icon(Icons.date_range),
                                      //     const SizedBox(width: 5),
                                      //     Text(
                                      //       "Date: "
                                      //       "${controller.programs[i]['Schedule_dates']}",
                                      //       style: const TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 15,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     const Icon(Icons.date_range),
                                      //     const SizedBox(width: 5),
                                      //     Text(
                                      //       "Time: "
                                      //       "${controller.programs[i]['Schedule_times']}",
                                      //       style: const TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 15,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          // Add action for editing the session
                                        },
                                        child: const Text(
                                          'cancel',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      TextButton(
                                        onPressed: () {
                                          // Add action for deleting the session
                                        },
                                        child: const Text(
                                          'complete',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
