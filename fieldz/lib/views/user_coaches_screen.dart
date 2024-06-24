import 'package:fieldz/controllers/user_coaches_controller.dart';
import 'package:fieldz/models/coach.dart';
import 'package:fieldz/views/user_coach_details_screen.dart';
import 'package:fieldz/views/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachesScreen extends StatelessWidget {
  CoachesScreen({super.key});

  final CoachesController controller = Get.put(CoachesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Coaches",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            toolbarHeight: 60,
            centerTitle: true,
            backgroundColor: Colors.blueAccent),
        drawer: userDrawer(),
        body: Obx(() => controller.isLoaded.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.getCoaches();
                },
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(7, 10, 7, 3),
                      child: SizedBox(
                          width: Get.width - 25,
                          child: Row(children: [
                            Expanded(
                                child: TextField(
                                    controller: controller.searchController,
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      labelText: 'Search',
                                      labelStyle: const TextStyle(fontSize: 18),
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ))),
                            const SizedBox(width: 10),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child: const Text(
                                    'Filter by Sport',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ]))),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.coaches.length,
                      itemBuilder: (context, index) {
                        Coach coach = controller.coaches[index];
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => UserCoachDetailsScreen(),
                                  arguments: {'coach': coach});
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(coach.avatarUrl),
                                      radius: 40,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            coach.username,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${coach.sport[0].toUpperCase() + coach.sport.substring(1)} Coach',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow[700],
                                                  size: 18),
                                              const SizedBox(width: 5),
                                              Text(
                                                coach.rating.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                '${coach.availableSessions} Quick Session${coach.availableSessions! > 1 ? "s" : ""}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                '${coach.availablePlans} Subscription Plan${coach.availablePlans! > 1 ? "s" : ""}',
                                                style: const TextStyle(
                                                  fontSize: 14,
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
                    ),
                  )
                ]))
            : const Center(child: CircularProgressIndicator())));
  }
}
