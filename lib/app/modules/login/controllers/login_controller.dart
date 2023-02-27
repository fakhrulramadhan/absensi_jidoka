import 'package:absensi_jidoka/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    isLoading.value = true;

    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = false;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        if (userCredential.user != null) {
          //Get.toNamed(Routes.HOME);
          Get.toNamed(Routes.DASHBOARD_UTAMA);
          // if (passwordC.text == "123456") {
          //   Get.toNamed(Routes.HOME);
          // }
        } else {
          Get.snackbar("Gagal Login",
              "Harap masukkan email dan \n Password dengan benar",
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          //print('No user found for that email.');
          //muncul alert
          Get.snackbar(
              "Terjadi Error", "Email yang digunakan tidak terdaftar di sistem",
              backgroundColor: Colors.red[400], colorText: Colors.white);
          isLoading.value = false; //agar text loginnya bisa diganti
        } else if (e.code == 'wrong-password') {
          //print('Wrong password provided for that user.');
          Get.snackbar("Terjadi Error", "Password anda salah",
              backgroundColor: Colors.red[400], colorText: Colors.white);
          isLoading.value = false; //agar text loginnya bisa diganti
        }
      } catch (e) {
        isLoading.value = false; //agar text loginnya bisa diganti
        //catch error secara general
        Get.snackbar("Terjadi Error", "Maaf, anda tidak bisa login",
            backgroundColor: Colors.red[400], colorText: Colors.white);
        //isLoading.value = false; //agar text loginnya bisa diganti
      }
    }
  }
}
