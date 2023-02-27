import 'package:get/get.dart';

import '../controllers/absensi_online_controller.dart';

class AbsensiOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsensiOnlineController>(
      () => AbsensiOnlineController(),
    );
  }
}
