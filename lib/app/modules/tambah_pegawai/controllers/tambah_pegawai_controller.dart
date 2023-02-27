import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TambahPegawaiController extends GetxController {
  //TODO: Implement TambahPegawaiController

  TextEditingController nipC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passadminC = TextEditingController();
  TextEditingController departemenC = TextEditingController();
  TextEditingController dateInputC = TextEditingController();
  final count = 0.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingTambahPegawai = false.obs;
  var selectedRole = 'admin'.obs;
  var selectedJabatan = 'programmer-odoo'.obs;
  var selectedDepartemen = 'it'.obs;

  var selectedDate = DateTime.now().obs;
  //var dateInput = DateTime.now().obs;

  FirebaseAuth auth = FirebaseAuth.instance; //instanse firebaseauth
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    dateInputC.text = "";
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void onSelected(String value) {
    selectedRole.value = value;
  }

  void onSelectedJabatan(String value) {
    selectedJabatan.value = value;
  }

  void onSelectedDepartemen(String value) {
    selectedDepartemen.value = value;
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
      //selectableDayPredicate: disableDate,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  //utk matiin tanggal sebelumnya
  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    );
    if (pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate!;
    }
  }

  //fungsinya menggunakan future karena akan dieksekusi nantti
  //future, async-await
  Future<void> addpegawaiprocess() async {
    //print("Tambah Pegawai");

    if (passadminC.text.isNotEmpty) {
      isLoadingTambahPegawai.value =
          true; //tulisan tambah pegawai menjafi tungggu
      //utk handle error
      try {
        //menyimpan email adminnya dulu
        //current user digunakan utk mengambil data yang login saat ini
        //email sudah pasti ada
        String emailAdmin = auth.currentUser!.email!;

        //passwordnya itu sama dengan password pas login
        //fakhrul => fakhrul cobakatalon => cobakatalon
        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passadminC.text);

        //pegawaiCredential diguakan utk add data pegawai
        UserCredential pegawaiCredential =

            //ditambahkan ke authentication firebase
            await auth.createUserWithEmailAndPassword(
                email: emailC.text,
                password: "password" //bikin default user baru =  password
                );

        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          //tammbah data ke firestore coll pegawai
          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "nama": namaC.text,
            "email": emailC.text,
            //"departemen": departemenC.text,
            "departemen": selectedDepartemen.value,
            "uid": uid,
            "jabatan": selectedJabatan.value,
            "role": selectedRole.value, //dapatin nilai option boxnya
            //"role": "pegawai", //rolenya pegawai, admin
            "created_at": DateTime.now()
          });
          //verified email masih false

          //utk kirim email verifikasi ke gmail (bagi gmail yang terdaftar)
          await pegawaiCredential.user!
              .sendEmailVerification(); //sendemailnya future

          //verified emailnya true
        }

        //utk mendapatkann uid (ada kemungkinan null)
        // String? uid = pegawaiCredential.user?.uid;
        //print(uid);
        Get.snackbar("Sukses", "Data Pegawai Berhasil ditambahkan",
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.toNamed(Routes.DASHBOARD_UTAMA);

        //supaya data sebelumnya enggak kesimpan
        nipC.text = "";
        namaC.text = "";
        emailC.text = "";

        ///print(userCredential);

        //harus ada logout ototmatis setelah penambahan data pegawai,
        //karena kalau tidak ada logout otomatis, maka setelah tambah pegawai
        //data yang muncul di auth user console log yaitu data yang pegawai baru
        //yang baru didaftarin
        //bukan data (current user) user yang login,

        //maka dari itu harus login ulang

        await auth.signOut();

        //enggak login sebagai siapa siapa
        //currentuser = null

        //login ulang dengan alamat email yang sudah login (email admin saja)
        //pakai admin yang akun fakhrul

        //setiap mau menambahkan pegawai baru, harus minta validasi admin dulu
        //opsi pertama: minta validasi admin pas add pegawai baru, dan harus
        //masukkin password
        //opsi kedua: ketika login sebagai admin, menyimpan password nya di login
        //controller (opsi yang kurang tepat),krn kalau restart datanya hilang
        //await auth.signInWithEmailAndPassword(email: email, password: password)

        //masuk lagi
        UserCredential userCredentialAdminRelogin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passadminC.text);

        Get.off(Routes.DASHBOARD_PROFILE);
        //Get.back(); //turup dialog
        //Get.back(); //back to home
        isLoadingTambahPegawai.value = false;
        Get.snackbar("Berhasil", "Berhasil menambahkan pegawai");
      } on FirebaseAuthException catch (e) {
        isLoadingTambahPegawai.value = false;

        //pengecekan passwordnya disini
        if (e.code == 'weak-password') {
          //print('The password provided is too weak.');
          //munculin alert message
          Get.snackbar("Terjadi Error", "Password yang digunakan masih lemah",
              colorText: Colors.white, backgroundColor: Colors.green);
        } else if (e.code == 'email-already-in-use') {
          //print('The account already exists for that email.');
          //cek di bagian authentication firebase apakah emailnya sudah ada
          //atau belum
          Get.snackbar(
              "Terjadi Error",
              '''Data Email Pegawai sudah ada,
            anda tidak bisa tambah alamat email yang sama''',
              colorText: Colors.white,
              backgroundColor: Colors.green);
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Error",
              '''Admin tidak dapat login, Password anda salah''',
              colorText: Colors.white, backgroundColor: Colors.green);
        } else {
          Get.snackbar("Terjadi Error", e.code.toString(),
              colorText: Colors.white, backgroundColor: Colors.green);
        }
      } catch (e) {
        isLoadingTambahPegawai.value = false;
        //print(e);
        // Get.snackbar("Masih ada yang kosng", "Semua field wajib diisi",
        //     colorText: Colors.white, backgroundColor: Colors.green);
      }
    } else {
      isLoading.value == false;
      Get.snackbar("Terjadi Error", "Password wajib diisi utk validasi",
          colorText: Colors.white, backgroundColor: Colors.green);
    }
  }

  Future<void> tambahpegawai() async {
    if (nipC.text.isEmpty && namaC.text.isEmpty & nipC.text.isEmpty) {
      Get.snackbar("Masih ada yang kosong", "Semua field wajib diisi",
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      isLoading.value = true; //istunggunya dinyalain
      //default dialog utk minta validasi admin, sebelum tambah data pegawai
      //buat validasi password admin yang login (passwordnya sesuai dengan
      //password yang digunakan)
      Get.defaultDialog(
          title: "Validasi Admin",
          //penggnti middletext (text), content (widget)
          content: Column(
            children: [
              const Text(
                "Masukkan Password: ",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                autocorrect: false,
                controller: passadminC,
                obscureText: true, //agar teksnya tidak kelihatan
                decoration: const InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value == false;
                isLoadingTambahPegawai.value == false;
                Get.back();
              },
              child: const Text(
                "Batal",
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    isLoading.value == false;
                    await addpegawaiprocess();
                  },
                  child: Text(
                    //kalau isloadingnya mati maka tambah pegawai
                    isLoadingTambahPegawai.isFalse
                        ? "Tambah Pegawai"
                        : "Tunggu....",
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ))
          ]);
      //utk handle error
      //try -catchnya kita pindahkan ke sebuah fungsi
      // try {

      //   UserCredential userCredential =

      //       //ditambahkan ke authentication firebase
      //       await auth.createUserWithEmailAndPassword(
      //           email: emailC.text,
      //           password: "password" //bikin default password
      //           );
      //   if (userCredential.user != null) {
      //     String uid = userCredential.user!.uid;

      //     //tammbah data ke firestore coll pegawai
      //     await firestore.collection("pegawai").doc(uid).set({
      //       "nip": nipC.text,
      //       "nama": namaC.text,
      //       "email": emailC.text,
      //       "uid": uid,
      //       "created_at": DateTime.now()
      //     });
      //     //verified email masih false

      //     //utk kirim email verifikasi ke gmail (bagi gmail yang terdaftar)
      //     await userCredential.user!
      //         .sendEmailVerification(); //sendemailnya future

      //     //verified emailnya true
      //   }

      //   //utk mendapatkann uid (ada kemungkinan null)
      //   // String? uid = userCredential.user?.uid;
      //   //print(uid);
      //   Get.snackbar("Sukses", "Data Pegawai Berhasil ditambahkan",
      //       colorText: Colors.white, backgroundColor: Colors.green);
      //   Get.toNamed(Routes.HOME);

      //   //supaya data sebelumnya enggak kesimpan
      //   nipC.text = "";
      //   namaC.text = "";
      //   emailC.text = "";

      //   ///print(userCredential);

      //   //harus ada logout ototmatis setelah penambahan data pegawai,
      //   //karena kalau tidak ada logout otomatis, maka setelah tambah pegawai
      //   //data yang muncul di auth user console log yaitu data yang pegawai baru
      //   //yang baru didaftarin
      //   //bukan data (current user) user yang login,

      //   //maka dari itu harus login ulang

      //   await auth.signOut();

      //   //enggak login sebagai siapa siapa
      //   //currentuser = null

      //   //login ulang dengan alamat email yang sudah login (email admin saja)
      //   //pakai admin yang akun fakhrul

      //   //setiap mau menambahkan pegawai baru, harus minta validasi admin dulu
      //   //opsi pertama: minta validasi admin pas add pegawai baru, dan harus
      //   //masukkin password
      //   //opsi kedua: ketika login sebagai admin, menyimpan password nya di login
      //   //controller (opsi yang kurang tepat),krn kalau restart datanya hilang
      //   await auth.signInWithEmailAndPassword(email: email, password: password)

      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     //print('The password provided is too weak.');
      //     //munculin alert message
      //     Get.snackbar("Terjadi Error", "Password yang digunakan masih lema");
      //   } else if (e.code == 'email-already-in-use') {
      //     //print('The account already exists for that email.');
      //     Get.snackbar("Terjadi Error", '''Data Email Pegawai sudah ada,
      //       anda tidak bisa tambah alamat email yang sama''');
      //   }
      // } catch (e) {
      //   //print(e);
      //   Get.snackbar("Masih ada yang kosng", "Semua field wajib diisi");
      // }
    }

    // @override
    // void onInit() {
    //   super.onInit();
    // }

    // @override
    // void onReady() {
    //   super.onReady();
    // }

    // @override
    // void onClose() {
    //   super.onClose();
    // }

    // void increment() => count.value++;
  }
}
