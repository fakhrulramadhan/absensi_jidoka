import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_presensi_controller.dart';
import 'package:intl/intl.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic>? data = Get.arguments;
  DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailPresensiView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200),
              padding: const EdgeInsets.all(22),
              child: Column(
                //berlawanan arah orientasinya jadinya ke samping
                crossAxisAlignment: CrossAxisAlignment.start, //paling kiri
                children: [
                  Center(
                    child: Text(
                      DateFormat.yMMMEd().format(DateTime.now()),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  const Text(
                    "Masuk",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  //formatnya j(am) menit second
                  // Text(
                  //   "Masuk Jam: ${DateFormat.jms().format(DateTime.now())}",
                  //   style: const TextStyle(
                  //       fontSize: 18.0, fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    "Masuk Jam: ${DateFormat.jms().format(DateTime.parse(data!['masuk']['date']))}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),

                  // const Text( const nilainya tetap
                  //   "Posisi Latitude: -6.328983391, 192.3391",
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  Text(
                    //cara panggil data di dalam mappiig
                    "Posisi Di Daerah: ${data!['masuk']['address']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),

                  // const Text(
                  //   "Status: Di Dalam Area",
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  Text(
                    "Status: ${data!['masuk']['status']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  //first utk memunculkan data hasil dari id
                  Text(
                    "Jarak: ${data!['masuk']['distance'].toString().split('.').first} Meter",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Latitude: ${data!['masuk']['lat']} Longtitude: ${data?['masuk']['long']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   "Keluar Jam: ${DateFormat.jms().format(DateTime.now())}",
                  //   style: const TextStyle(
                  //       fontSize: 18.0, fontWeight: FontWeight.bold),
                  // ),

                  //? tanyakan dulu karena datanya blm tentu ada
                  Text(
                    data?["keluar"]?["date"] == null
                        ? "Keluar Jam: -"
                        : "Keluar Jam: ${DateFormat.jms().format(DateTime.parse(data!["keluar"]["date"]))}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),

                  // const Text(
                  //   "Posisi Latitude: -6.328983391, 192.3391",
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  Text(
                    data?['keluar']?['address'] == null
                        ? "Posisi Di Daerah: -"
                        : "Posisi di Daerah: ${data!['keluar']['address']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),

                  // const Text(
                  //   "Status: Di Dalam Area",
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  //? datanya belum tentu ada
                  Text(
                    data?['keluar']?['status'] == null
                        ? "Status: -"
                        : "Status: ${data!['keluar']['status']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  //komanya dihilangin (. menjadi " ")
                  Text(
                    data?['keluar']?['distance'] == null
                        ? "Jarak: -"
                        : "Jarak: ${data!['keluar']['distance'].toString().split('.').first} Meter",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    data?['keluar']?['lat'] == null &&
                            data?['keluar']?['long'] == null
                        ? "Latitude: -  Longtitude: -"
                        : "Latitude: ${data!['keluar']['lat']} Longtitude: ${data!['keluar']['long']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
