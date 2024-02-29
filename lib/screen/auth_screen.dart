import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:need_me/controllers/auth_controller.dart';

final firebase = FirebaseAuth.instance;

class AddWork extends StatefulWidget {
  const AddWork({super.key});

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  bool islogin = true;
  final formKey = GlobalKey<FormState>();
  File? pickedImagefile;
  var submitemail = '';
  var submitpassword = '';
  var enterusername = '';
  var submitusername = '';
  var submitworkrate = '';
  int? submitphonenumber = 0;
  String? submitwork = '';
  String? submitarea = '';
  final List<String> profession = [
    'Electrician',
    'Massion',
    'Plumber',
    'Labour',
    'Carpenter',
  ];
  final List<String> yourArea = ['Anta', 'Baran', 'Sultanpur', 'Kota'];

  void submitForm() async {
    final isvalid = formKey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    formKey.currentState!.save();
    try {
      if (islogin) {
        final userkr = await firebase.signInWithEmailAndPassword(
            email: submitemail, password: submitpassword);

        // print(userkr.credential);
      } else {
        final usercr = await firebase.createUserWithEmailAndPassword(
            email: submitemail, password: submitpassword);
        final storegeref = FirebaseStorage.instance
            .ref()
            .child('User-Image')
            .child('${usercr.user!.uid}.jpeg');
        await storegeref.putFile(pickedImagefile!);
        final imageurl = await storegeref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('User-Data')
            .doc(usercr.user!.uid)
            .set({
          'User Name': submitusername,
          'User-Image': imageurl,
          'User-E-mailid': submitemail,
          'User-password': submitpassword,
          'User-work-Rate': submitworkrate,
          'User-Mobile-Number': submitphonenumber,
          'User-work': submitwork,
          'User-Area': submitarea,
          'User-Id': usercr.user!.uid
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentcation faild')));
    }
  }

  void pickImage() async {
    final pickeimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickeimage == null) {
      return null;
    }

    setState(() {
      pickedImagefile = File(pickeimage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!islogin)
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: pickedImagefile != null
                          ? FileImage(pickedImagefile!)
                          : null,
                    ),
                  if (!islogin)
                    ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: const Text('Upload Image')),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'enter valid e mail';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      submitemail = newValue.toString();
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'enter gamail id'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length <= 6) {
                          return 'enter valid password';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        submitpassword = newValue.toString();
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'enter password')),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!islogin)
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Sapce between words not alowed';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        submitusername = newValue!;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Enter Your Full Name.',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!islogin)
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Sapce between words not alowed';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        submitworkrate = newValue!;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Enter Your Work Rate.',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!islogin)
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Sapce between words not alowed';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null && newValue.isNotEmpty) {
                          submitphonenumber = int.tryParse(newValue);
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Enter Your Mobile Number.',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  const SizedBox(height: 15),
                  if (!islogin)
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        'Select Your Work',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: profession
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Ypur work.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          submitwork = value;
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!islogin)
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        'Select Your Area',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: yourArea
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Area.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        submitarea = value;
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  const SizedBox(height: 15),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        submitForm();
                        controller.fetchData();
                      },
                      child: Text(islogin ? 'sign in' : 'sign up')),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        islogin = !islogin;
                      });
                    },
                    child: Text(
                        islogin ? 'create account' : 'i already have account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
