import 'package:get/get.dart';

import '../controllers/logindeny_controller.dart';

class LogindenyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogindenyController>(
      () => LogindenyController(),
    );
  }
}
