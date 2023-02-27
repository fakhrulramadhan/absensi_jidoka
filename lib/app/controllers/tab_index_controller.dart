import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';

class BottombarIndexController extends GetxController {
  //TODO: Implement PageIndexController

  final count = 0.obs;

  RxInt pageIndex = 0.obs;

  //inisiasi dulu
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void doAbsensi() async {
    //await determinePosition(); //panggil fungsi ini agar dapatin lokasinya

    //tipe datanya posittion
    //await determinePosition();
    //Map<String, dynamic> position = await determinePosition();
    Map<String, dynamic> dataResponsePosition = await determinePosition();

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services atau GPs are enabled/ nyala.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    //jika gps belum dinyalakan.
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      Get.snackbar("Error", "Harap Nyalakan GPS terlebih dahulu",
          backgroundColor: Colors.red, colorText: Colors.white);
      //return Future.error('Location services are disabled.');
      // return {
      //   "message": "Tidak dapat mengambil GPS dari perangkat ini",
      //   "error": false
      // };
    }

    //jika tidak error
    if (!dataResponsePosition["error"]) {
      Position position = dataResponsePosition["position"];
      //print("${position.latitude} . ${position.longitude}");

      //update position (sekaligus simpan ke firebase)nyaa
      //dapatin posisi latitude longtitude
      //await updatePosition(position);

      //ubah dari lat longtitude ke bentuk lokasi (geocoding)
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      //kalau ada permasalahan dengan channel, harus run ulang

      //print(placemarks); //dapatin nama lokasinya
      // for (var element in placemarks) {
      //   print(element);
      // }

      //print(placemarks[1].street);

      // print(placemarks[0].runtimeType); //tipe datanya placemark
      // print(placemarks[0].name); //dapatin namanya,  tipenya placemark
      // print(placemarks[1].street); //dapatin nama jalannya
      // print(placemarks[0].subLocality);
      // print(placemarks[0].country);

      // Get.snackbar("${dataResponsePosition['message']} ",
      //     "${position.latitude} . ${position.longitude}",
      //     backgroundColor: Colors.green, colorText: Colors.white);

      // print(
      //     "${placemarks[0].name} ${placemarks[1].street} . ${placemarks[0].subLocality} . ${placemarks[0].locality}");

      //dapatin address nya
      String address =
          "${placemarks[0].name}, ${placemarks[1].street} ,\n${placemarks[0].subLocality} ,\n${placemarks[0].locality} ,\n${placemarks[0].subAdministrativeArea} ";

      //update data ke firebase
      await updatePosition(position, address);

      //cek jarak  diantara 2  posisi (start lat long dari sd 3 sukaharja)
      //endlatitude end long didapat dari posisi sekarang tipenya double
      double distance = Geolocator.distanceBetween(
          -6.3554106, 107.2642593, position.latitude, position.longitude);

      //update daata ke tabel  absensi
      await absensi(position, address, distance);

      // Get.snackbar("${dataResponsePosition['message']}", address,
      //     backgroundColor: Colors.green, colorText: Colors.white);

      // Get.snackbar("Berhasil Absensi", "Anda telah mengisi daftar hadir",
      //     backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "${dataResponsePosition['message']} ");
    }
    print("Selesai");
  }

  void changePage(int i) async {
    print("Change index $i");

    //ubah pageIndex menjadi i
    pageIndex.value = i;

    switch (i) {
      case 1:
        //await determinePosition(); //panggil fungsi ini agar dapatin lokasinya

        //tipe datanya posittion
        //await determinePosition();
        //Map<String, dynamic> position = await determinePosition();
        Map<String, dynamic> dataResponsePosition = await determinePosition();

        bool serviceEnabled;
        LocationPermission permission;

        // Test if location services atau GPs are enabled/ nyala.
        serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (dataResponsePosition["error"]) {
          Get.snackbar("Error", "Harap Nyalakan GPS terlebih dahulu",
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        //jika gps belum dinyalakan.
        // if (!serviceEnabled) {
        //   // Location services are not enabled don't continue
        //   // accessing the position and request users of the
        //   // App to enable the location services.

        //   Get.snackbar("Error", "Harap Nyalakan GPS terlebih dahulu",
        //       backgroundColor: Colors.red, colorText: Colors.white);
        //   //return Future.error('Location services are disabled.');
        //   // return {
        //   //   "message": "Tidak dapat mengambil GPS dari perangkat ini",
        //   //   "error": false
        //   // };
        // }

        //jika tidak error
        if (!dataResponsePosition["error"]) {
          Position position = dataResponsePosition["position"];
          //print("${position.latitude} . ${position.longitude}");

          //update position (sekaligus simpan ke firebase)nyaa
          //dapatin posisi latitude longtitude
          //await updatePosition(position);

          //ubah dari lat longtitude ke bentuk lokasi (geocoding)
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          //kalau ada permasalahan dengan channel, harus run ulang

          //print(placemarks); //dapatin nama lokasinya
          // for (var element in placemarks) {
          //   print(element);
          // }

          //print(placemarks[1].street);

          // print(placemarks[0].runtimeType); //tipe datanya placemark
          // print(placemarks[0].name); //dapatin namanya,  tipenya placemark
          // print(placemarks[1].street); //dapatin nama jalannya
          // print(placemarks[0].subLocality);
          // print(placemarks[0].country);

          // Get.snackbar("${dataResponsePosition['message']} ",
          //     "${position.latitude} . ${position.longitude}",
          //     backgroundColor: Colors.green, colorText: Colors.white);

          // print(
          //     "${placemarks[0].name} ${placemarks[1].street} . ${placemarks[0].subLocality} . ${placemarks[0].locality}");

          //dapatin address nya
          String address =
              "${placemarks[0].name}, ${placemarks[1].street} ,\n${placemarks[0].subLocality} ,\n${placemarks[0].locality} ,\n${placemarks[0].subAdministrativeArea} ";

          //update data ke firebase
          await updatePosition(position, address);

          //cek jarak  diantara 2  posisi (start lat long dari sd 3 sukaharja)
          //endlatitude end long didapat dari posisi sekarang tipenya double
          double distance = Geolocator.distanceBetween(
              -6.3554106, 107.2642593, position.latitude, position.longitude);

          //update daata ke tabel  absensi
          await absensi(position, address, distance);

          // Get.snackbar("${dataResponsePosition['message']}", address,
          //     backgroundColor: Colors.green, colorText: Colors.white);

          // Get.snackbar("Berhasil Absensi", "Anda telah mengisi daftar hadir",
          //     backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Error", "${dataResponsePosition['message']} ");
        }
        print("Selesai");
        break;
      case 2: //index yang paling kanan
        Get.offAllNamed(Routes.DASHBOARD_PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.DASHBOARD_UTAMA); //default diarahkan ke home
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  /// gpsnya harus dinyalain dulu
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //return Future.error('Location services are disabled.');
      // return {
      //   "message": "Tidak dapat mengambil GPS dari perangkat ini",
      //   "error": false
      // };

      Get.snackbar("Error", "Anda perlu menyalakan GPS terlebih dahulu",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //return Future.error('Location permissions are denied');
        Get.snackbar("Error", "Anda perlu menyalakan GPS terlebih dahulu",
            backgroundColor: Colors.red, colorText: Colors.white);
        return {"message": "Izin menggunakan GPS ditolak", "error": false};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Anda perlu menyalakan GPS terlebih dahulu",
          backgroundColor: Colors.red, colorText: Colors.white);
      return {
        "message":
            "Settingan hp nda tidak memperbolehkan utk mmmengakses GPS /n harap diubah pada settingannya",
        "error": false
      };
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition(); //dapat positionnya

    //secara default location accuracynya pakai yang best
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high //tinggi akurasinya
        );
    //returnnya harus dalam bentuk mapping juga
    return {
      "position": position,
      "message": "Berhasi mendapatkan posisi perangkat",
      "error": false
    };
  }

  //fungsi update ke tabel  absensi
  Future<void> absensi(
      Position position, String address, double distance) async {
    //menambah subcollection dulu

    String uid = auth.currentUser!.uid;

    DateTime sekarang = DateTime.now();

    //merubah format datetime sekarang
    DateFormat.yMd().format(sekarang);

    //replace ganti / menjadi strip -
    //dijadikan sebagai docid
    String todayDocId = DateFormat.yMd().format(sekarang).replaceAll("/", "-");

    //masuk ke doc uid nya current user (where nya)
    //dari doc uid buat collection bstu lsgi
    CollectionReference<Map<String, dynamic>> colAbsensi =
        firestore.collection("pegawai").doc(uid).collection("absensi");

    DocumentReference<Map<String, dynamic>> colabsensitoday = firestore
        .collection("pegawai")
        .doc(uid)
        .collection("absensi")
        .doc(todayDocId);

    //buat doc baru tanggal hari ini (snapshot / get)
    QuerySnapshot<Map<String, dynamic>> snapAbsensi = await colAbsensi.get();

    Future<DocumentSnapshot<Map<String, dynamic>>> snapAbsensiToday =
        colabsensitoday.get();

    //print(); //cek jml data absensi

    //print(todayDocId);

    //sebelum  dimasukkan ke database, kelola dulu distancenya
    String status = "Di Luar Area Perusahaan"; //set status default di luar area

    //<= 1000 meter
    if (distance <= 500) {
      //didalam area
      status = "Di Dalam Area Perusahaan";
    } else {
      //diluar area
      status;
    }

    //lengthnya kosong baru dibuat absen masuk (snapAbsensi.docs.isEmpty)
    if (snapAbsensi.docs.isEmpty) {
      //validasi dulu, di await dulu
      await Get.defaultDialog(
          title: "Validasi Absen Masuk",
          middleText:
              "Apakah anda yakin akan mengisi daftar hadir (Masuk) Sekarang?",
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text(
                "Batal",
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //blm pernah absen masuk, absen pertama kalinya
                //set data mamsuk. simpan datanya ke dalam tipe map masuk
                await colAbsensi.doc(todayDocId).set({
                  //utk mengurutkan berdasarkan tanggal
                  "date": sekarang.toIso8601String(),
                  "masuk": {
                    "date": sekarang.toIso8601String(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "status": status,
                    "distance": distance //dalam satuan meter
                  }
                });

                Get.back();

                Get.snackbar(
                    "Berhasil Absensi", "Anda telah mengisi daftar hadir",
                    backgroundColor: Colors.green, colorText: Colors.white);
              },
              child: const Text(
                "Ya",
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )
          ]);
    } else {
      //sudah pernah absen -> cek hari ini sudah
      //absen masuk / keluar belum

      //cek absensi hari ini
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colAbsensi.doc(todayDocId).get();

      //print(todayDoc.exists); //true / false

      //data absen hari ini ada
      if (todayDoc.exists == true) {
        //tinggal buat absen keluar atau sudah absen masuk & keluar
        //tipenya mapping
        Map<String, dynamic>? dataAbsenceToday = todayDoc.data();

        //print(dataAbsenceToday);

        //jika data absen keluarnya ada (datanya blm tentu ada ?)
        if (dataAbsenceToday?["keluar"] != null) {
          //sudah absen masuk dan keluar

          Get.snackbar("Sukses", "Anda Sudah Absen masuk & Keluar",
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          //tampilin get default dialog dulu kalau mau absen keluar
          await Get.defaultDialog(
              title: "Validasi Absen Pulang",
              middleText: "Apakah Yakin Ingin Absen Pulang?",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Batal",
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //enggak perlu seet
                    //buat absen keluar
                    //update (utk update data berdasaarkan data )
                    await colAbsensi.doc(todayDocId).update({
                      //utk mengurutkan berdasarkan tangga
                      "keluar": {
                        "date": sekarang.toIso8601String(),
                        "lat": position.latitude,
                        "long": position.longitude,
                        "address": address,
                        "status": status,
                        "distance": distance
                      }
                    });

                    Get.back();

                    Get.snackbar(
                        "Berhasil Absensi", "Anda telah mengisi Absensi Pulang",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  },
                  child: const Text(
                    "Ya",
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                )
              ]);
        }
      } else {
        //print("dijalankan");
        //kalau belum, buat absen masuk
        //set (utk tambah data berdasaarkan data yang diset)
        await colAbsensi.doc(todayDocId).set({
          //utk mengurutkan berdasarkan tanggal
          "date": sekarang.toIso8601String(),
          "masuk": {
            "date": sekarang.toIso8601String(),
            "lat": position.latitude,
            "long": position.longitude,
            "address": address,
            "status": status,
            "distance": distance
          }
        });
      }
    }
  }

  //lempar data dulu (sebagai parameter) di updateposition
  //pakai parametr position dan address

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    //masuk ke doc uid nya current user (where nya)
    await firestore.collection("pegawai").doc(uid).update({
      //field position tipenya mapping (update posisi)
      "position": {"lat": position.latitude, "long": position.longitude},
      "address": address
    });
  }
}
