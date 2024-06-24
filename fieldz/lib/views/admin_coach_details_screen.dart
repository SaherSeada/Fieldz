import 'package:fieldz/controllers/admin_coach_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCoachDetailsPage extends StatelessWidget {
  AdminCoachDetailsPage({Key? key}) : super(key: key);

  final AdminCoachDetailsController controller =
      Get.put(AdminCoachDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.coach.username),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(() => controller.isLoaded.value
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(controller.coach.avatarUrl),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.coach.sport[0].toUpperCase() + controller.coach.sport.substring(1)} Coach',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            _buildRatingStars(controller.coach.rating),
                          ],
                        ),
                        const Spacer(),
                        Icon(
                          controller.coach.status == 'verified'
                              ? Icons.check_circle
                              : controller.coach.status == 'rejected'
                                  ? Icons.warning
                                  : Icons.info,
                          color: controller.coach.status == 'verified'
                              ? Colors.green
                              : controller.coach.status == 'rejected'
                                  ? Colors.red
                                  : Colors.orange,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildProfileInfo('Name', controller.coach.username),
                    _buildProfileInfo('Email', controller.coach.email),
                    _buildProfileInfo('User Name', controller.coach.username),
                    _buildProfileInfo(
                        'Phone Number', controller.coach.phoneNumber),
                    const SizedBox(height: 18),
                    _buildProfileInfo(
                        'Status',
                        controller.coach.status![0].toUpperCase() +
                            controller.coach.status!.substring(1)),
                    controller.coach.status == "pending"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    controller.onPressed('verified');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // Background color
                                  ),
                                  child: const Text('Verify'),
                                ),
                                const SizedBox(
                                    width: 20), // Add space between the buttons
                                ElevatedButton(
                                  onPressed: () {
                                    controller.onPressed('rejected');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red, // Background color
                                  ),
                                  child: const Text('Reject'),
                                ),
                              ],
                            ))
                        : const SizedBox()
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator())));
  }

  Widget _buildProfileInfo(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: false,
          controller: TextEditingController(text: info),
          decoration: const InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
          size: 20,
        );
      }),
    );
  }
}
