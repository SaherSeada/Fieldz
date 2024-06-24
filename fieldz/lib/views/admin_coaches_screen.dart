import 'package:fieldz/controllers/admin_coaches_controller.dart';
import 'package:fieldz/models/coach.dart';
import 'package:fieldz/views/admin_coach_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCoachesListPage extends StatelessWidget {
  AdminCoachesListPage({super.key});

  final AdminCoachesController controller = Get.put(AdminCoachesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Coaches"),
          // title: TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Search...',
          //     filled: true,
          //     fillColor: Colors.grey[200],
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(30),
          //       borderSide: BorderSide.none,
          //     ),
          //     prefixIcon: Icon(Icons.search, color: Colors.grey),
          //   ),
          // ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await controller.getCoaches();
            },
            child: SingleChildScrollView(
                child: Obx(() => controller.isLoaded.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Pending Coaches",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            controller.pendingCoaches.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.pendingCoaches.length,
                                    itemBuilder: (context, index) {
                                      var coach =
                                          controller.pendingCoaches[index];
                                      return coachWidget(coach);
                                    },
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Center(
                                        child: Text("No Pending Coaches",
                                            style: TextStyle(fontSize: 16)))),
                            const SizedBox(height: 20),
                            const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Active Coaches",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            controller.activeCoaches.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.activeCoaches.length,
                                    itemBuilder: (context, index) {
                                      var coach =
                                          controller.activeCoaches[index];
                                      return coachWidget(coach);
                                    },
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Center(
                                        child: Text("No Active Coaches",
                                            style: TextStyle(fontSize: 16)))),
                            const SizedBox(height: 20),
                            const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Rejected Coaches",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            controller.rejectedCoaches.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.rejectedCoaches.length,
                                    itemBuilder: (context, index) {
                                      var coach =
                                          controller.rejectedCoaches[index];
                                      return coachWidget(coach);
                                    },
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Center(
                                        child: Text("No Rejected Coaches",
                                            style: TextStyle(fontSize: 16)))),
                          ])
                    : const Center(child: CircularProgressIndicator())))));
  }

  coachWidget(Coach coach) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            onTap: () {
              Get.to(() => AdminCoachDetailsPage(),
                  arguments: {'coach': coach});
            },
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(coach.avatarUrl),
            ),
            title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  coach.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            subtitle:
                Text(coach.sport[0].toUpperCase() + coach.sport.substring(1)),
            trailing: Wrap(
              spacing: 12,
              children: <Widget>[
                Icon(
                  coach.status == 'verified'
                      ? Icons.check_circle
                      : coach.status == 'rejected'
                          ? Icons.warning
                          : Icons.info,
                  color: coach.status == 'verified'
                      ? Colors.green
                      : coach.status == 'rejected'
                          ? Colors.red
                          : Colors.orange,
                  size: 30,
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ));
  }
}
