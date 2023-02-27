import 'package:get/get.dart';

import '../controllers/izinpersetujuanlist_controller.dart';

class IzinpersetujuanlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinpersetujuanlistController>(
      () => IzinpersetujuanlistController(),
    );
  }
}
