import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izinpersetujuanlist_controller.dart';

class IzinpersetujuanlistView extends GetView<IzinpersetujuanlistController> {
  const IzinpersetujuanlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IzinpersetujuanlistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'IzinpersetujuanlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
