import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SemuaPresensiController extends GetxController {
  //TODO: Implement SemuaPresensiController

  final count = 0.obs;

  //inisiasi database dulu
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //bikin inisiasi tanggal mulai - selesai dulu
  DateTime? start; //ada kemungkinan null
  //default tanggal akhirnya tanggal hari iin
  DateTime end = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllPresence() async* {
    String uid = auth.currentUser!.uid;

    String dateToday =
        DateFormat.yMMMd().format(DateTime.now()).replaceAll("/", "-");

    //masuk ke collection absensi dulu
    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("absensi")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPresence() async {
    String uid = auth.currentUser!.uid;

    // String dateToday =
    //     DateFormat.yMMMd().format(DateTime.now()).replaceAll("/", "-");

    print(start);
    print(end);
    //masuk ke collection absensi dulu
    // return firestore
    //     .collection("pegawai")
    //     .doc(uid)
    //     .collection("absensi")
    //     .orderBy("date", descending: true)
    //     .get(); //ngambilnya sekali aja

    if (start == null) {
      //get seluruh data presensi
      //querynya salah

      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("absensi")
          //filter date dari tanggal setelah s date yang dipilih

          //ubah ke iso string dulu karena di firebase tipenya string
          //jika tanggal end nya kurang dari yang dipilih (hari ini defaultnya)
          .where("date", isLessThan: end.toIso8601String())
          .orderBy("date", descending: true)
          .get(); //ngambilnya sekali aja

      //print(test.docs); //kosong karena blm pilih tanggal
      // test.docs.forEach((element) {
      //   print(element.data());
      // });

      // return await firestore
      //     .collection("pegawai")
      //     .doc(uid)
      //     .collection("absensi")
      //     //filter date dari tanggal setelah s date yang dipilih

      //     .where("date", isLessThan: end)
      //     .orderBy("date", descending: true)
      //     .get(); //ngambilnya sekali aja
    } else {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("absensi")
          //filter date dari tanggal setelah s date yang dipilih
          //kalau blm convert ke iso string, maka tidak akan munccul
          //datanya
          .where("date", isGreaterThan: start!.toIso8601String())
          //kalau eggak pakai add duation, maka endnya jam 00:00 di tanggal endnya
          //kalau pakai add duration, maka endnya di hari besok
          .where("date",
              isLessThan: end.add(const Duration(days: 1)).toIso8601String())
          .orderBy("date", descending: true)
          .get(); //ngambilnya sekali aja
    }
  }

  //fungsi utk dapatin tanggalnya
  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update(); //update refresh render UI

    Get.back(); //utk tutup
  }

  void increment() => count.value++;
}
