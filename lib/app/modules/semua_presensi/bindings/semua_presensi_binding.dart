import 'package:get/get.dart';

import '../controllers/semua_presensi_controller.dart';

class SemuaPresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SemuaPresensiController>(
      () => SemuaPresensiController(),
    );
  }
}
