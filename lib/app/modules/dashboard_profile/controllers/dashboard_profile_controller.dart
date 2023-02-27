import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardProfileController extends GetxController {
  //TODO: Implement DashboardProfileController

  final count = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void increment() => count.value++;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    //user yang login sekaraang pakai role apa
    // await = tunggu dulu
    String uid = auth.currentUser!.uid;

    //yield utk memantau secara stream
    //snapshotnya masih bentuk objek
    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
