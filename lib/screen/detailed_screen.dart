import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:need_me/controllers/auth_controller.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen(
      {super.key,
      required this.id,
      required this.workrate,
      required this.mobilenumber,
      required this.imageurl,
      required this.name,
      required this.works});
  final String imageurl;
  final String name;
  final String works;
  final String workrate;
  final int mobilenumber;
  final String id;
  void directCall() async {
    await FlutterPhoneDirectCaller.callNumber(mobilenumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(167, 236, 240, 1),
            ),
            Positioned(
                top: 35,
                left: 5,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))),
            Positioned(
                top: 35,
                left: 300,
                child: IconButton(
                    onPressed: () {
                      controller.deleteAccount(id);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete))),
            Positioned(
                top: 60,
                left: 110,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          imageurl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87),
                    ),
                    Text(works,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black87)),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 1000 * 0.33),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              height: 450,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WorkRate       $workrate',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black54)),
                      const Text('Experience     ${8} Year',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 135, 244, 244)),
                      onPressed: () {
                        directCall();
                      },
                      child: const Text(
                        'Call User',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
