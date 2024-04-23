import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerController>(
      () => DrawerController(),
    );
  }
}
