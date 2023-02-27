import 'package:get/get.dart';

import '../controllers/izinpengajuanlist_controller.dart';

class IzinpengajuanlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinpengajuanlistController>(
      () => IzinpengajuanlistController(),
    );
  }
}
