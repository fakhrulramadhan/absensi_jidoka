import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';
import 'package:connectivity_checker/connectivity_checker.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  //tangkap data dari profile view
  final Map<String, dynamic> user = Get.arguments;

  //parameter id buat hapus foto
  FirebaseAuth auth = FirebaseAuth.instance;

  UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // print(user); //ngecek user arguments

    final updatePegawaiForm = GlobalKey<FormState>();
    //ambil data user sesuai id login (arguments)
    controller.nipC.text = user['nip'];
    controller.namaC.text = user['nama'];
    controller.emailC.text = user['email'];

    String uid = auth.currentUser!.uid;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Profil',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Image.asset(
            "assets/jidoka.png",
            width: 90.0,
            height: 90.0,
            fit: BoxFit.fill,
          ),
          foregroundColor: Colors.white, //warna teks dan panah
          //backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue.shade100, Colors.blue.shade200]),
            ),
          ),
        ),
        body: ConnectivityWidgetWrapper(
          child: ListView(
            padding: const EdgeInsets.all(23),
            children: [
              Column(
                //pasang align di kiri
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                      key: updatePegawaiForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.all(20)),
                          TextFormField(
                            autocorrect: false,
                            readOnly: true, //nip tidak bisa diganti

                            ///buat handle nip
                            controller: controller.nipC,
                            decoration: const InputDecoration(
                              labelText: 'NIP',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "NIP Wajib diisi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 17.0,
                          ),
                          TextFormField(
                            autocorrect: false,
                            readOnly: true,
                            controller: controller.emailC,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email Wajib diisi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 17.0,
                          ),
                          TextFormField(
                            autocorrect: false,
                            controller: controller.namaC,
                            decoration: const InputDecoration(
                              labelText: 'Nama',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama Wajib diisi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 17.0,
                          ),

                          // const SizedBox(
                          //   height: 20.0,
                          // ),
                          // DropdownButton(
                          //   // Initial Value
                          //   value: dropdownvalue,

                          //   // Down Arrow Icon
                          //   icon: const Icon(Icons.keyboard_arrow_down),

                          //   // Array list of items
                          //   items: items.map((String items) {
                          //     return DropdownMenuItem(
                          //       value: items,
                          //       child: Text(items),
                          //     );
                          //   }).toList(),
                          //   // After selecting the desired option,it will
                          //   // change button value to selected value
                          //   onChanged: (String? newValue) {
                          //     //pengganti setstate
                          //     setState(() {
                          //       dropdownvalue = newValue!;
                          //     });
                          //   },
                          // ),

                          const Text(
                            "Foto Profile",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.,
                            //saling menjauh
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // user["profile_picture"] != null &&
                              //         user["profile_picture"] != ""
                              //     ? const Text(
                              //         "Foto Profile",
                              //         style: TextStyle(
                              //           fontSize: 14.0,
                              //         ),
                              //       )
                              //     : const Text(
                              //         "Belum dipilihh",
                              //         style: TextStyle(
                              //           fontSize: 12.0,
                              //         ),
                              //       ),

                              //pantau dengan getbuilder, tipenya diisi dengan
                              //nama controller
                              //minusnya getbuilder tidak langsung update otomatis
                              GetBuilder<UpdateProfileController>(
                                  builder: (controller) {
                                if (controller.image != null) {
                                  //sudah pasti ada
                                  // return const Text(
                                  //   "Foto Ada",
                                  //   style: TextStyle(
                                  //     fontSize: 13.0,
                                  //   ),
                                  // );
                                  //menampilkan gambar
                                  return ClipOval(
                                    child: SizedBox(
                                      height: 120,
                                      width: 120,
                                      //pilih yang image file, karena membutuhkan direktori path file dari hpnya
                                      child: Image.file(
                                        File(controller.image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                } else {
                                  //jika c.imageya kosong (ada 2 kondisi)
                                  if (user["profile_picture"] != null) {
                                    return Column(
                                      children: [
                                        ClipOval(
                                          child: SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: Image.network(
                                              user["profile_picture"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.deletePhoto(uid);
                                          },
                                          child: const Text("Hapus Foto"),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Text(
                                      "No Image choosen",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                }
                              }),

                              //pakai package image_picker buat ambil foto
                              TextButton(
                                onPressed: () {
                                  controller.pickImage();
                                },
                                child: const Text(
                                  "Pilih File",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Obx(() => ElevatedButton(
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    if (updatePegawaiForm.currentState!
                                        .validate()) {
                                      //pakai parameter uidnya
                                      await controller
                                          .updateprofile(user['uid']);
                                    }
                                  }
                                },
                                child: Text(
                                  controller.isLoading.isFalse
                                      ? "Update Pegawai"
                                      : "Tunggu...",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ))
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
