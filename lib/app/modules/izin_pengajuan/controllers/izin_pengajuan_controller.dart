import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fbasestorage;

import '../../../routes/app_pages.dart';

class IzinPengajuanController extends GetxController {
  //TODO: Implement IzinPengajuanController

  final count = 0.obs;

  TextEditingController nipC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController lokasitujuanC = TextEditingController();

  RxBool isLoading = false.obs;

  //utk dapatin uidnya, ambil dari uidnya aja

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //nama variabelnya storage
  fbasestorage.FirebaseStorage storage = fbasestorage.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image; //enggak bisa dipanntau karena tipenya bukan rx

  //untuk ambil gambar
  void pickImage() async {
    // Pick an image
    //final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //td enggak muncul karena taruh xfilenya disini, bukan diluar
    image = await picker.pickImage(source: ImageSource.gallery);

    // if (image != null) {
    //   //kalau pilih gambar, akan dapat path dan name
    //   print(image!.name); //test dulu
    //   print(image!.path);

    //   print(image!.name.split(".").last);

    //   //mengupdate / setstate UI kalau ada datanya aja
    //   //update();
    // } else {
    //   //kalau membatalkan hasilnya null (atau pilihan gambar dari yg terakhir)
    //   print(image);
    // }

    update(); //update diseluruhnya
  }

  //karena di await,jadinya fungsi nya pakai tipe future
  //tidak butuh firebaseauth karena sudah ada (dapat) uidnya
  Future<void> updateprofile(String uid) async {
    isLoading.value == true;
    //pastiin dulu datanya ada
    if (nipC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        lokasitujuanC.text.isNotEmpty) {
      try {
        //data yang diupdate awal awal bentuknya mapping
        Map<String, dynamic> data = {
          "nip": nipC.text,
          "nama": namaC.text,
          "lokasi_tujuan": lokasitujuanC.text
        };

        //kalau fotonya ada,langsung upload
        if (image != null) {
          //pakai package path_provider,  buat dapatin path filenya
          //atau bisa langsung dari imahe
          // Directory appDocDir = await getApplicationDocumentsDirectory();
          // String filePath = '${appDocDir.absolute}/file-to-upload.png';
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          //nama folder yang ditaruh ke storage, nama foldernya uid
          //suaah berhasil upload
          await storage.ref('$uid/profile.$ext').putFile(file);

          //harus benaran masukkin url yang benar, ini buat url ke firestore
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          //cara dapatin link url  dari storage yakni pakai download url
          data.addAll({"izindinas_picture": urlImage});

          await firestore
              .collection("pegawai")
              .doc(uid)
              .collection("izin_dinas")
              .doc(uid)
              .set({
            "nip": nipC.text,
            "nama": namaC.text,
            "lokasi_tujuan": lokasitujuanC.text,
            "izindinas_picture": urlImage,
            "status": "Proses"
          });
        }
        // await firestore
        //     .collection("pegawai")
        //     .doc(uid)
        //     .collection("izin_dinas")
        //     .doc(uid)
        //     .set({
        //      "nip": nipC.text,
        //   "nama": namaC.text,
        //   "lokasi_tujuan": lokasitujuanC.text,
        //   "izindinas_picture": urlImage
        //     });
        Get.snackbar("Sukses", "Data Profile anda berhasil diupdate");
        Get.toNamed(Routes.DASHBOARD_UTAMA);
        isLoading.value = false;
        image = null; //agar kosongin isi di image nya
      } catch (e) {
        Get.snackbar("Terjadi Error", "Tidak dapat Update Profile");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Error", "Semua data wajib diisi");
    }
  }

  void deletePhoto(String uid) async {
    try {
      //enggak bisa hapus karena salah nama fieldnya -_-
      await firestore.collection("pegawai").doc(uid).update({
        "profile_picture": FieldValue.delete() //utk hapus photo profile
      });

      update();

      Get.back(); //kalau belumm di get back fotonya mmasih ada
      //update(); //agar hilang fotonya di UI
      Get.snackbar("Berhasil", "Foto Profil berhasil dihapus");

      //Get.toNamed(Routes.PROFILE);
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat hapus Foto Profil");
    } finally {
      update();
    }
  }

  void increment() => count.value++;
}
