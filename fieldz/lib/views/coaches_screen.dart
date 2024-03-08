import 'package:fieldz/controllers/coaches_controller.dart';
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
            centerTitle: true,
            backgroundColor: Colors.blueAccent),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.coaches.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 190,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(children: [
                                            Text(
                                              controller.coaches[index]
                                                  .name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 12, 5, 0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${controller.coaches[index].price} EGP/session",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: List.generate(
                                                            5, (i) {
                                                          if (i <
                                                              int.parse(controller
                                                                          .coaches[
                                                                      index].rating)) {
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
                                                      ),
                                                    ]))
                                          ]),
                                          CircleAvatar(
                                            radius: 35.0,
                                            backgroundImage: NetworkImage(
                                                controller.coaches[index].avatarUrl),
                                            backgroundColor: Colors.transparent,
                                          )
                                        ]),
                                    const SizedBox(height: 15),
                                    Center(
                                        child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blueAccent),
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  const Size(30, 30))),
                                      child: const Text("Book",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ))
                                  ])),
                        ))));
              },
            ),
          )
        ]));
  }
}
