import 'package:absensi_jidoka/app/controllers/tab_index_controller.dart';
import 'package:absensi_jidoka/app/modules/dashboard_utama/controllers/dashboard_utama_controller.dart';
import 'package:absensi_jidoka/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:connectivity_checker/connectivity_checker.dart';

import '../controllers/dashboard_profile_controller.dart';

class DashboardProfileView extends GetView<DashboardProfileController> {
  // final pageDp = Get.put(DashboardProfileController());

  final pageDu = Get.find<DashboardUtamaController>();
  final pageC = Get.find<BottombarIndexController>();
  DashboardProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profil',
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
        body: ConnectivityWidgetWrapper(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text("No Connection Available"),
                  );
                }
                if (snapshot.hasData) {
                  Map<String, dynamic> user =
                      snapshot.data!.data()!; //ada datanya !

                  String defaultImage =
                      "https://ui-avatars.com/api/?name=$user['nama']";

                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.refresh,
                          size: 24.0,
                        ),
                        title: const Text("Update Profil"),
                        //butuh arguments sbg parameter id
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                        },
                      ),
                      //role admin yang hanya bisa akses ini
                      if (user["role"] == "hrd")
                        ListTile(
                          leading: const Icon(
                            Icons.add,
                            size: 24.0,
                          ),
                          title: const Text("Tambah Pegawai"),
                          onTap: () {
                            Get.toNamed(Routes.TAMBAH_PEGAWAI);
                          },
                        ),
                      ListTile(
                        leading: const Icon(
                          Icons.change_circle,
                          size: 24.0,
                        ),
                        title: const Text("Ganti Tema"),
                        onTap: () {
                          Get.toNamed(Routes.GANTI_TEMA);
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 24.0,
                        ),
                        title: const Text("Logout"),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAllNamed(Routes.LOGIN);

                          // Get.toNamed(Routes.LOGIN); //sementara
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("No Connection Available"),
                  );
                }
              }),
        ),
        bottomNavigationBar: ConvexAppBar(
          //agar statis
          style: TabStyle.fixedCircle,

          //halaman yang dituju ada di contrllers/page_index_controoller

          //buat controllernya utk navigasi
          //get create controller:nama_page
          items: const [
            TabItem(icon: Icons.home, title: 'Beranda'),
            TabItem(icon: Icons.fingerprint, title: 'Absensi'),
            TabItem(icon: Icons.people, title: 'Profil'),
          ],
          //ketika diklik menu bar nya, akan pindah halaman
          onTap: (int i) => pageC.changePage(i),
          //pakai controller yang pageindcontroller
          initialActiveIndex: pageC.pageIndex.value, //harus pakai value
        ));
  }
}
