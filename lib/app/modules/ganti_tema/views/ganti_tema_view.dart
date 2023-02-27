import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ganti_tema_controller.dart';
import '../../../../theme/color.dart';

class GantiTemaView extends GetView<GantiTemaController> {
  const GantiTemaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ganti Tema'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Ganti Tema",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Get.changeTheme(Get.isDarkMode ? light : dark),
                  child: const Text(
                    "Ubah Tema",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
