import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class IzinController extends GetxController {
  //TODO: Implement IzinController

  final count = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    //user yang login sekaraang pakai role apa
    // await = tunggu dulu
    String uid = auth.currentUser!.uid;

    //yield utk memantau secara stream
    //snapshotnya masih bentuk objek
    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  void increment() => count.value++;
}
