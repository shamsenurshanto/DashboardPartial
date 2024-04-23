import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class DrawerController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString selectedItem = Routes.DASHBOARD.obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void changeSelectedItem(String value) {
    selectedItem.value = value;
    update();
  }
}
