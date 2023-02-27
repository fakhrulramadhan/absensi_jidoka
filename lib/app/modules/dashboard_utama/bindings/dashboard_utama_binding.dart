import 'package:get/get.dart';

import '../controllers/dashboard_utama_controller.dart';

class DashboardUtamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardUtamaController>(
      () => DashboardUtamaController(),
    );
  }
}
