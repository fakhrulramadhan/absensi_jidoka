import 'package:get/get.dart';

import '../controllers/ganti_tema_controller.dart';

class GantiTemaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GantiTemaController>(
      () => GantiTemaController(),
    );
  }
}
