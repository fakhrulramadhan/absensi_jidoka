import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/semua_presensi_controller.dart';
import 'package:intl/intl.dart';

class SemuaPresensiView extends GetView<SemuaPresensiController> {
  const SemuaPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SemuaPresensiView'),
        centerTitle: true,
      ),
      body: GetBuilder<SemuaPresensiController>(
        builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: controller.getPresence(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      "Belum ada data absensi",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true, //ngegabung dengan parent listviewnya
                //tidak bisa discroll
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //ontap gesturedeetector agak kaku
                  //ontap inkweell lebih animate
                  //warna default bawaan dari inkwell warna hitam
                  //(ketika di ontap)

                  //pakai ? karena datanya blm tentu ada
                  Map<String, dynamic>? data =
                      snapshot.data?.docs[index].data();

                  //kalau pakai container, enggak ada efek warnanya
                  return Padding(
                    //padding: const EdgeInsets.all(22),
                    //agar atasnya bis paling mentok
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 22),
                    child: Material(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          print("Detail Kehadiran");
                          //buat argument utk mendapatkan semua data id
                          //current user yang login  arguments: dataaccount
                          Get.toNamed(Routes.DETAIL_PRESENSI,
                              arguments: data); //ke det presensi
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(21),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Colors.grey[300],
                            //jangan taruh warna di container
                          ),
                          child: Column(
                            //cross (berlawanan)
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //install packagee intl utk dapatin waktu masuk & keluar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  //g usah pakai sizedboox karena space nya pakai
                                  //main axis
                                  // const SizedBox(
                                  //   w: 5.0,
                                  // ),

                                  //ubah dari datetime ke string pakai
                                  //datetime parse terus .tostring

                                  //formatnya hari, bulan tanggal tahun
                                  Text(
                                    data?["masuk"]?["date"] == null
                                        ? "-"
                                        : DateFormat.yMMMEd()
                                            .format(DateTime.parse(
                                                data!["masuk"]!["date"]))
                                            .toString(),
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                //hms : format wkt 24 jam
                                //jms : formatnya am pm
                                DateFormat.jms().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "Keluar",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data?["keluar"]?["date"] == null
                                    ? "-"
                                    : DateFormat.jms()
                                        .format(DateTime.parse(
                                            data!["keluar"]["date"]))
                                        .toString(),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
