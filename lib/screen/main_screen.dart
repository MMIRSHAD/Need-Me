import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:need_me/controllers/auth_controller.dart';
import 'package:need_me/widgets/woekcard.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  final int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(167, 236, 240, 1),
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: const Text('MainScreen'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.category.length,
                      itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                                onTap: () {
                                  controller.getCategory(index);
                                  controller.setSelectedIndex(index);
                                },
                                child: Chip(
                                    backgroundColor:
                                        // ignore: unrelated_type_equality_checks
                                        controller.selectedIndex == index
                                            ? Colors.amber
                                            : Colors.transparent,
                                    label: Text(controller.category[index]))),
                          )),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: controller.fetchdata.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2),
                      itemBuilder: (ctx, index) => WorkCard(
                            imageurl: controller.fetchdata[index]['User-Image'],
                            rate: controller.fetchdata[index]['User-work'],
                            name: controller.fetchdata[index]['User Name'],
                            work: controller.fetchdata[index]['User-work'],
                            workRate: controller.fetchdata[index]
                                ['User-work-Rate'],
                            mobile: controller.fetchdata[index]
                                ['User-Mobile-Number'],
                            id: controller.fetchdata[index]['User-Id'],
                          )),
                )
              ],
            ),
          )),
    );
  }
}
