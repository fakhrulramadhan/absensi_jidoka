import 'package:get/get.dart';

import '../controllers/izin_persetujuan_controller.dart';

class IzinPersetujuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinPersetujuanController>(
      () => IzinPersetujuanController(),
    );
  }
}
