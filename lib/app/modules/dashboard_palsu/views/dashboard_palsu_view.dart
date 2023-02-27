import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_palsu_controller.dart';

class DashboardPalsuView extends GetView<DashboardPalsuController> {
  const DashboardPalsuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardPalsuView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardPalsuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
