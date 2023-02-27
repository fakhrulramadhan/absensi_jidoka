import 'package:absensi_jidoka/app/modules/dashboard_profile/controllers/dashboard_profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_palsu_controller.dart';

class DashboardPalsuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPalsuController>(
      () => DashboardPalsuController(),
    );
    Get.put(DashboardProfileController());
  }
}
