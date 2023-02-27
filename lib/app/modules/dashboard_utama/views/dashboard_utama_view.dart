import 'package:absensi_jidoka/app/controllers/tab_index_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_utama_controller.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_offline/flutter_offline.dart';

class DashboardUtamaView extends GetView<DashboardUtamaController> {
  final pageDu = Get.find<DashboardUtamaController>();
  final pageC = Get.find<BottombarIndexController>();
  DashboardUtamaView({Key? key}) : super(key: key);

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
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.NOTIFIKASI);
              },
              icon: const Icon(
                Icons.notifications,
                size: 24.0,
              ),
            )
          ],
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

        //jangan pakai listview

        //kalau nampilin listtile parentnya harus listview
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;

              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.all(20)),
                      const SizedBox(
                        height: 20.0,
                      ),
                      AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: connected ? 0 : 1,
                          child: Container(
                            height: 30,
                            color: connected ? Colors.green : Colors.red,
                            child: Center(
                              child: Text(
                                connected ? "Online" : "Offline",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        //utk nama karyawannya
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamRole(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              //pertama ambil rolenya dulu dari fbase, sudah pasti ada datanya
                              //String role = snapshot.data!.data()!["role"];

                              if (snapshot.hasData) {
                                //harus ada elsenya
                                Map<String, dynamic> datapeg =
                                    snapshot.data!.data()!;

                                String defaultImage =
                                    "https://ui-avatars.com/api/?name=$datapeg['nama']";
                                return Container(
                                  height: 320,
                                  width: 330,
                                  //color: Colors.grey[300],
                                  padding: const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(23),
                                      //color: const Color.fromARGB(255, 221, 213, 213)
                                      gradient: LinearGradient(colors: [
                                        Colors.green.shade200,
                                        Colors.grey.shade200
                                      ])),
                                  child: Column(
                                    //pasang align di kiri
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            //
                                            child: Container(
                                              //width nya tetap 100% karena berada di listview,
                                              //maka dari itu bungkus container dengan row
                                              width: 90,
                                              height: 90,
                                              color: Colors.grey[300],
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/cowok.jpg",
                                                  width: 64.0,
                                                  height: 64.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                //     Image.network(
                                                //   "https://i.pinimg.com/originals/dd/a2/a3/dda2a32f73df13df918c730e35ac3705.jpg",
                                                //   fit: BoxFit.cover,
                                                // )
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            //dapatin data departemen dari snapshot stream
                                            "${datapeg['nama']}",
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "${datapeg['nip']}",
                                        style: const TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "${datapeg['jabatan']}",
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      SingleChildScrollView(
                                        //scrollDirection: Axis.vertical,
                                        child: Text(
                                          datapeg["address"] == null
                                              ? "Belum ada lokasi"
                                              : "${datapeg["address"]}",
                                          style: const TextStyle(
                                            fontSize: 11.0,
                                          ),
                                          textAlign: TextAlign.left,
                                          // overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                          // softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    "Tidak ada Data User",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamToday(),
                            builder: (context, snaphariini) {
                              if (snaphariini.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              print(snaphariini.data?.data());

                              //datanya belum tentu ada
                              Map<String, dynamic>? datahariini =
                                  snaphariini.data?.data();

                              return Container(
                                height: 100,
                                width: 330,
                                //color: Colors.grey[300],
                                padding: const EdgeInsets.all(22),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23),
                                    //color: const Color.fromARGB(255, 221, 213, 213)
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 206, 232, 247),
                                      Color.fromARGB(255, 245, 255, 110)
                                    ])),
                                child: Row(
                                  //pasang align di kiri
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      //width: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Masuk",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            datahariini?['masuk'] == null
                                                ? "-"
                                                :
                                                //format jam menit
                                                DateFormat.jm().format(
                                                    DateTime.parse(
                                                        datahariini!["masuk"]
                                                            ["date"])),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      //width: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //kalau belum tentu ada pakai ?
                                          const Text(
                                            "Keluar",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            datahariini?['keluar'] == null
                                                ? "-"
                                                : DateFormat.jm().format(
                                                    DateTime.parse(
                                                        datahariini!["keluar"]
                                                            ["date"])),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Menu",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.streamRole(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.hasData) {
                              Map<String, dynamic> datapeg =
                                  snapshot.data!.data()!;
                              return Wrap(
                                spacing: 20, //spasi kesamping
                                runSpacing: 10, //spasi kebawah
                                direction: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.ABSENSI_ONLINE);
                                    },
                                    child: SizedBox(
                                      width: 70,
                                      height: 120,
                                      //color: Colors.brown,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            //color: Colors.green,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.purple,
                                                    Colors.orange
                                                  ],
                                                )),
                                            child: const Icon(
                                              Icons.book,
                                              size: 24.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const Text(
                                            "Absensi",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          //color: Colors.green,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                              )),
                                          child: const Icon(
                                            Icons.beach_access_outlined,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          "Tugas",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          //color: Colors.green,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                              )),
                                          child: const Icon(
                                            Icons.work,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          "Perubahan Jadwal",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.IZIN,
                                            arguments: datapeg);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            //color: Colors.green,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.purple,
                                                    Colors.orange
                                                  ],
                                                )),
                                            child: const Icon(
                                              Icons.notes_sharp,
                                              size: 24.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const Text(
                                            "Izin Dinas",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          //color: Colors.green,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                              )),
                                          child: const Icon(
                                            Icons.money,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          "Lembur",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          //color: Colors.green,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                              )),
                                          child: const Icon(
                                            Icons.health_and_safety,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          "Jadwal",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 120,
                                    //color: Colors.brown,
                                    child: GestureDetector(
                                      onTap: () {
                                        openBottomSheet();
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            //color: Colors.green,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.purple,
                                                    Colors.orange
                                                  ],
                                                )),
                                            child: const Icon(
                                              Icons.other_houses,
                                              size: 24.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const Text(
                                            "Menu Lain",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: Text("Belum ada data"),
                              );
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Riwayat Absensi",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SEMUA_PRESENSI);
                            },
                            child: const Text(
                              "Lihat Selengkapnya",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamLastPresence(),
                          builder: (context, snaplasthadir) {
                            if (snaplasthadir.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snaplasthadir.connectionState ==
                                ConnectionState.none) {
                              return const Center(
                                child: Text(
                                  "Tidak ada Koneksi Internet",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }

                            print(snaplasthadir.data!.docs.length);

                            if (snaplasthadir.data!.docs.isEmpty ||
                                snaplasthadir.data == null &&
                                    snaplasthadir.data!.docs.isEmpty) {
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: Text(
                                    "Belum ada histori Absensi",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              itemCount: snaplasthadir.data!.docs.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Map<String, dynamic>? data =
                                    snaplasthadir.data?.docs[index].data();
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: Material(
                                    //color: Colors.grey[300],
                                    //color: ,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.DETAIL_PRESENSI,
                                            arguments: data);
                                        //print("Detail Kehadiran");
                                        //buat argument utk mendapatkan semua data id
                                        //current user yang login
                                        //  arguments: dataaccount
                                        //argumentsnya tidak usah pakai data.id
                                        //karena idnya otomatis ambil dari indexnya
                                        // Get.toNamed(Routes.DETAIL_PRESENSI,
                                        //     arguments: data); //ke det presensi
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(21),
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.blue,
                                              Colors.red,
                                            ],
                                          ),
                                          //color: Colors.grey[300],
                                          //jangan taruh warna di container
                                        ),
                                        child: Column(
                                          //cross (berlawanan)
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //install packagee intl utk dapatin waktu masuk & keluar
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Masuk",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white),
                                                ),
                                                //g usah pakai sizedboox karena space nya pakai
                                                //main axis
                                                // const SizedBox(
                                                //   w: 5.0,
                                                // ),
                                                Text(
                                                  data?["date"] == null
                                                      ? "-"
                                                      : DateFormat.yMMMEd()
                                                          .format(
                                                              DateTime.parse(
                                                                  data![
                                                                      "date"]))
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            // Text(
                                            //   //hms : format wkt 24 jam
                                            //   //jms : formatnya am pm
                                            //   //jam masuk diammbil masuk datenya
                                            //   DateFormat.jms().format(
                                            //       DateTime.parse(data["date"])),
                                            //   style: const TextStyle(
                                            //       fontSize: 12.0,
                                            //       fontWeight: FontWeight.bold),
                                            // ),

                                            //error timestamp, berarti ganti date yang
                                            //ada di firebase dari timestamp ke string
                                            Text(
                                              //pakai ?karena datanya blm tentu ada
                                              data?["masuk"]?["date"] == null
                                                  ? "-"
                                                  : DateFormat.jms()
                                                      .format(DateTime.parse(
                                                          data!["masuk"]
                                                              ["date"]))
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const Text(
                                              "Keluar",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            //error karena ada kemungkinan kosoong
                                            Text(
                                              data?["keluar"]?["date"] == null
                                                  ? "-"
                                                  : DateFormat.jms()
                                                      .format(DateTime.parse(
                                                          data!["keluar"]
                                                              ["date"]))
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                    ],
                  ),
                ],
              );
            },
            child: const SizedBox(
              height: 1.0,
            )),
        bottomNavigationBar: ConvexAppBar(
          //agar statis
          style: TabStyle.reactCircle,

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
    // bottomSheet: Obx(() =>
    //  BottomSheet(
    //     elevation: 10,
    //     backgroundColor: Colors.amber,
    //     enableDrag: false,
    //     onClosing: () {},
    //     builder: (BuildContext ctx) => Container(
    //           width: double.infinity,
    //           height: 250,
    //           alignment: Alignment.center,
    //           child: ElevatedButton(
    //             child: const Text(
    //               'Close this bottom sheet',
    //             ),
    //             onPressed: () {},
    //           ),
    //         ))),
  }
}

void openBottomSheet() {
  Get.bottomSheet(
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Wrap(
            spacing: 20, //spasi kesamping
            runSpacing: 10, //spasi kebawah
            direction: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ABSENSI_ONLINE);
                },
                child: SizedBox(
                  width: 70,
                  height: 120,
                  //color: Colors.brown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        //color: Colors.green,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.purple, Colors.orange],
                            )),
                        child: const Icon(
                          Icons.book,
                          size: 24.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Absensi",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.beach_access_outlined,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Tugas",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.work,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Perubahan Jadwal",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.IZIN);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        //color: Colors.green,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.purple, Colors.orange],
                            )),
                        child: const Icon(
                          Icons.notes_sharp,
                          size: 24.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Izin Dinas",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.money,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Lembur",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.health_and_safety,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Jadwal",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.money,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Slip Gaji",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.money,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Kontrak",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.thumb_up,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Tanda Tangan",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.note_sharp,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Klaim",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.auto_graph,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Kaizen",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.book_rounded,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "SPT",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.book_online,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "E-Learning",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.house,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Horenso",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.graphic_eq_sharp,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Performa",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.money_off,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Pinjaman",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.people,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "BPJS",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.people_outline,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "SOS",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.notes_rounded,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "SOP",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 120,
                //color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          )),
                      child: const Icon(
                        Icons.car_rental,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Patroli",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const Center(
          //   child: Text(
          //     'Bottom Sheet',
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Tutup',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
