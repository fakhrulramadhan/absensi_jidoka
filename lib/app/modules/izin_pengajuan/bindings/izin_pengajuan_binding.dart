import 'package:get/get.dart';

import '../controllers/izin_pengajuan_controller.dart';

class IzinPengajuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinPengajuanController>(
      () => IzinPengajuanController(),
    );
  }
}
