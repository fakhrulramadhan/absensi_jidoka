import 'package:get/get.dart';

import '../controllers/absensi_offline_controller.dart';

class AbsensiOfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsensiOfflineController>(
      () => AbsensiOfflineController(),
    );
  }
}
