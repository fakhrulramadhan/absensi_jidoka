import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izin_persetujuan_controller.dart';

class IzinPersetujuanView extends GetView<IzinPersetujuanController> {
  const IzinPersetujuanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IzinPersetujuanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'IzinPersetujuanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
