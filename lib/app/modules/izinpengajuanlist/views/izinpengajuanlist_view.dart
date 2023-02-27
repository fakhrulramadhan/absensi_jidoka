import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izinpengajuanlist_controller.dart';

class IzinpengajuanlistView extends GetView<IzinpengajuanlistController> {
  const IzinpengajuanlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IzinpengajuanlistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'IzinpengajuanlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
