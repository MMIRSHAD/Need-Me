import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_me/controllers/auth_controller.dart';
import 'package:need_me/screen/detailed_screen.dart';

class WorkCard extends StatelessWidget {
  const WorkCard(
      {super.key,
      required this.id,
      required this.mobile,
      required this.work,
      required this.workRate,
      required this.imageurl,
      required this.name,
      required this.rate});
  final String imageurl;
  final String name;
  final String rate;
  final String work;
  final String workRate;
  final int mobile;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedScreen(
                        mobilenumber: mobile,
                        imageurl: imageurl,
                        name: name,
                        works: work,
                        workrate: workRate,
                        id: id,
                      )));
        },
        child: Card(
          color: const Color.fromRGBO(167, 236, 240, 1),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                fit: BoxFit.cover,
                imageurl,
                height: 150,
                width: double.maxFinite,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(name)),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(rate)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
