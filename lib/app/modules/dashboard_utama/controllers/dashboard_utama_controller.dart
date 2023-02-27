import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardUtamaController extends GetxController {
  //TODO: Implement DashboardUtamaController

  RxBool showBottomSheet = true.obs;

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //tipe nya stream, jadi di fungsinya harus pakai stream
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    //user yang login sekaraang pakai role apa
    String uid = auth.currentUser!.uid;

    //yield utk memantau secara stream
    //snapshotnya masih bentuk objek
    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamToday() async* {
    String uid = auth.currentUser!.uid;

    String todayId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    //yield sbg aliran data
    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("absensi")
        .doc(todayId)
        .snapshots();
  }

  //utk memantau (stream) absesnsi, tipenya querysnapshots
  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresence() async* {
    //user yang login sekaraang pakai role apa
    String uid = auth.currentUser!.uid;

    //masuk ke coollection dulu

    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("absensi")
        //dari tanggal terkahir dulu
        .orderBy("date", descending: true) //berdasarkan field date,
        .limitToLast(5) //mennampilkan 5 data terakhir
        .snapshots(); //snapshots tipenya querysnapshots
  }
}
