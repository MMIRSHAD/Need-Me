import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  List<Map<String, dynamic>> fetchdata = [];
  var selectedIndex = 0.obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  List<String> category = [
    'All',
    'Electrician',
    'Massion',
    'Plumber',
    'Labour',
    'Carpenter',
  ];
  @override
  void onInit() {
    fetchData();

    super.onInit();
  }

  void fetchData() async {
    try {
      QuerySnapshot productsnapshot =
          await FirebaseFirestore.instance.collection('User-Data').get();

      final userdata = productsnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      fetchdata.assignAll(userdata);
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  void getCategory(int index) async {
    try {
      QuerySnapshot productsnapshot =
          await FirebaseFirestore.instance.collection('User-Data').get();

      final userdata = productsnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      List<Map<String, dynamic>> filterData = [];

      String selectedCategory = category[index];

      filterData = userdata
          .where((userData) => userData['User-work'] == selectedCategory)
          .toList();
      fetchdata.assignAll(filterData);
      if (index == 0) {
        fetchdata.assignAll(userdata);
      }

      update();
    } catch (e) {
      print(e);
    }
  }

  void deleteAccount(String id) async {
    try {
      await FirebaseFirestore.instance.collection('User-Data').doc(id).delete();
      //  Get.snackbar('Delete', 'Product Deleted Succesfully');
    } catch (e) {
      print(e);
    }
    fetchData();
  }
}
