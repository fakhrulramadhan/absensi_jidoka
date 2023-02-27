import 'package:absensi_jidoka/app/modules/dashboard_utama/controllers/dashboard_utama_controller.dart';
import 'package:absensi_jidoka/app/modules/izin/controllers/izin_controller.dart';
import 'package:absensi_jidoka/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:connectivity_checker/connectivity_checker.dart';
import './app/controllers/tab_index_controller.dart';
import './app/modules/izin_pengajuan/controllers/izin_pengajuan_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //membutuhkan asyc (dan future) karena dia await
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //set permanent agar tidak hilang di memori
  final pageDu = Get.put(DashboardUtamaController(), permanent: true);
  //set permanent agar tidak hilang di memori
  final pageC = Get.put(BottombarIndexController(), permanent: true);
  final pageIP = Get.put(IzinPengajuanController(), permanent: true);

  final pageIC = Get.put(IzinController(), permanent: true);
  runApp(
    ConnectivityAppWrapper(
      app: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
