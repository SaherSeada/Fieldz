import 'package:fieldz/controllers/user_coach_details_controller.dart';
import 'package:fieldz/models/program.dart';
import 'package:fieldz/models/session.dart';
import 'package:fieldz/views/user_bookings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserCoachDetailsScreen extends StatelessWidget {
  UserCoachDetailsScreen({super.key});

  final UserCoachDetailsController controller =
      Get.put(UserCoachDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoaded.value
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                controller.coach.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.coach.avatarUrl),
                        radius: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        controller.coach.username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${controller.coach.sport[0].toUpperCase() + controller.coach.sport.substring(1)} Coach',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                        const SizedBox(width: 5),
                        Text(
                          controller.coach.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          controller.coach.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          controller.coach.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Available Sessions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...controller.sessions.asMap().entries.map((entry) {
                      int index = entry.key;
                      var session = entry.value;
                      return SessionCard(
                        session: session,
                        userID: controller.userID,
                        index: index,
                      );
                    }).toList(),
                    const SizedBox(height: 30),
                    const Text(
                      'Subscription Plans',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...controller.programs.asMap().entries.map((entry) {
                      int index = entry.key;
                      var program = entry.value;
                      return SubscriptionPlanCard(
                        program: program,
                        userID: controller.userID,
                        index: index,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}

class SessionCard extends StatelessWidget {
  final Session session;
  final String userID;
  final int index;

  final UserCoachDetailsController controller = Get.find();

  SessionCard(
      {super.key,
      required this.session,
      required this.userID,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Location: ${session.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Price: ${session.price.toStringAsFixed(2)} EGP',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Time: ${session.time}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Date: ${session.date}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Duration: ${session.duration.toInt()} Hour${session.duration > 1 ? 's' : ""}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Description: ${session.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Participants: ${session.users.length}/${session.capacity}',
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: session.users.contains(userID)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: const Text('Booked'),
                          onPressed: () {},
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text('Book'),
                          onPressed: () {
                            controller.book(index, "sessions");
                          },
                        ),
                ))
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final Program program;
  final String userID;
  final int index;

  final UserCoachDetailsController controller = Get.find();

  SubscriptionPlanCard(
      {super.key,
      required this.program,
      required this.userID,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Location: ${program.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Price: ${program.price.toStringAsFixed(2)} EGP/Month',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Session Duration: ${program.duration.toInt()} Hour${program.duration > 1 ? 's' : ""}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Description: ${program.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Participants: ${program.users.length}/${program.capacity}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Schedule:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            ...program.schedule.entries.map((entry) {
              return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    '${entry.key}: ${entry.value} - ${addHoursToTime(entry.value, program.duration.toInt())}',
                    style: const TextStyle(fontSize: 16),
                  ));
            }).toList(),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                    child: program.users.contains(userID)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            child: const Text('Subscribed'),
                            onPressed: () {},
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text('Subscribe'),
                            onPressed: () async {
                              var returnValue =
                                  await controller.book(index, "programs");
                              if (returnValue) {
                                Get.off(UserBookingsScreen());
                              }
                            },
                          )))
          ],
        ),
      ),
    );
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
