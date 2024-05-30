import 'package:fieldz/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Profile'),
          actions: [
            Obx(() => !controller.enableEdit.value
                ? TextButton(
                    onPressed: () {
                      controller.enableEdit.value = true;
                    },
                    child: const Text("Edit", style: TextStyle(fontSize: 16)))
                : TextButton(
                    onPressed: () {
                      controller.enableEdit.value = false;
                      controller.refreshDetails();
                    },
                    child:
                        const Text("Cancel", style: TextStyle(fontSize: 16))))
          ],
        ),
        body: Obx(() => controller.isLoaded.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshDetails();
                },
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 75,
                              backgroundImage: NetworkImage(
                                  controller.avatarController.text),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: controller.avatarController,
                              decoration: const InputDecoration(
                                labelText: 'Avatar URL',
                              ),
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.usernameController,
                              enabled: controller.enableEdit.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Username can't be empty.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.emailController,
                              enabled: controller.enableEdit.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email can't be empty.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.phoneController,
                              enabled: controller.enableEdit.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone number can't be empty.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                            ),
                            const SizedBox(height: 20),
                            controller.enableEdit.value
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.updateDetails();
                                      }
                                    },
                                    child: const Text('Save'),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    )))
            : const Center(child: CircularProgressIndicator())));
  }
}
