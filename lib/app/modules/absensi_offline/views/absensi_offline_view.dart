import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absensi_offline_controller.dart';

class AbsensiOfflineView extends GetView<AbsensiOfflineController> {
  const AbsensiOfflineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsensiOfflineView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AbsensiOfflineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
