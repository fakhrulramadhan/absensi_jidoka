import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  const AbsensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Jidoka ESS',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Image.asset(
            "assets/jidoka.png",
            width: 90.0,
            height: 90.0,
            fit: BoxFit.fill,
          ),
          foregroundColor: Colors.white, //warna teks dan panah
          //backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue.shade100, Colors.blue.shade200]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.wifi,
                  size: 24.0,
                ),
                label: const Text(
                  "Absensi Online",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.wifi,
                  size: 24.0,
                ),
                label: const Text(
                  "Absensi Offline",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
