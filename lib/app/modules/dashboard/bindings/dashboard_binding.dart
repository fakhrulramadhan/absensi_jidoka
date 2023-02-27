import 'package:absensi_jidoka/app/modules/dashboard_profile/controllers/dashboard_profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.put(DashboardProfileController());
  }
}
