import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absensi_online_controller.dart';

class AbsensiOnlineView extends GetView<AbsensiOnlineController> {
  const AbsensiOnlineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mulaiabsenmasuk = const TimeOfDay(hour: 06, minute: 00).format(context);
    var akhirabsenmasuk = const TimeOfDay(hour: 11, minute: 00).format(context);

    var mulaiabsenkeluar =
        const TimeOfDay(hour: 16, minute: 45).format(context);
    var akhirabsenkeluar =
        const TimeOfDay(hour: 23, minute: 00).format(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsensiOnlineView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text(
            "Absensi Masuk",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15.0,
          ),
          //if (DateTime.now().isAfter())
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.door_front_door,
              size: 24.0,
            ),
            label: const Text(
              "Check-In Absen Masuk",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            "Absensi Keluar",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.output,
              size: 24.0,
            ),
            label: const Text(
              "Check-Out Absen Pulang",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
