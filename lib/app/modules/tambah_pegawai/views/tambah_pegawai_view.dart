import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_pegawai_controller.dart';
import 'package:connectivity_checker/connectivity_checker.dart';

class TambahPegawaiView extends GetView<TambahPegawaiController> {
  const TambahPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final addPegawaiForm = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tambah Pegawai',
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
              Form(
                  key: addPegawaiForm,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,

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
                      TextFormField(
                        autocorrect: false,
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
                      // TextFormField(
                      //   autocorrect: false,
                      //   controller: controller.departemenC,
                      //   decoration: const InputDecoration(
                      //     labelText: 'Departemen',
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Departemen Wajib diisi";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Departemen",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 8, left: 16),
                          child: Obx(
                            () => DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              hint: const Text('Pilih Departemen'),
                              //ambil nilainya dari bag selectednya
                              value: controller.selectedDepartemen.value,
                              items: const [
                                DropdownMenuItem(
                                    value: "it", child: Text("IT")),
                                DropdownMenuItem(
                                    value: "sales", child: Text("Sales")),
                                DropdownMenuItem(
                                    value: "akuntan", child: Text("Akuntan")),
                                DropdownMenuItem(
                                    value: "direksi", child: Text("Direksi")),

                                // DropdownMenuItem(
                                //     value: "JOURNALIST",
                                //     child: Text("Journalist"))
                              ],
                              onChanged: (val) {
                                controller.onSelectedDepartemen(val!);
                              },
                            ),
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Jabatan",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 8, left: 16),
                          child: Obx(
                            () => DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              hint: const Text('Pilih Jabatan'),
                              value: controller.selectedJabatan.value,
                              items: const [
                                DropdownMenuItem(
                                    value: "programmer-odoo",
                                    child: Text("Programmer Odoo")),
                                DropdownMenuItem(
                                    value: "programmer-mobile",
                                    child: Text("Programmer Mobile")),
                                DropdownMenuItem(
                                    value: "supervisor-it",
                                    child: Text("Supervisor IT")),
                                DropdownMenuItem(
                                    value: "staff-akuntan",
                                    child: Text("Staff Akuntan")),
                                DropdownMenuItem(
                                    value: "staff-sales",
                                    child: Text("Staff Sales")),
                                DropdownMenuItem(
                                    value: "supervisor sales",
                                    child: Text("Supervisor Sales")),
                                DropdownMenuItem(
                                    value: "direktur", child: Text("Direktur")),
                                // DropdownMenuItem(
                                //     value: "JOURNALIST",
                                //     child: Text("Journalist"))
                              ],
                              onChanged: (val) {
                                controller.onSelectedJabatan(val!);
                              },
                            ),
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Role",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 8, left: 16),
                          child: Obx(
                            () => DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              hint: const Text('Pilih role'),
                              value: controller.selectedRole.value,
                              items: const [
                                DropdownMenuItem(
                                    value: "hrd", child: Text("HRD")),
                                DropdownMenuItem(
                                    value: "pegawai", child: Text("Pegawai")),
                                // DropdownMenuItem(
                                //     value: "JOURNALIST",
                                //     child: Text("Journalist"))
                              ],
                              onChanged: (val) {
                                controller.onSelected(val!);
                              },
                            ),
                          )),
                      // Obx(
                      //   () => Text(
                      //     DateFormat("dd-MM-yyyy")
                      //         .format(controller.selectedDate.value)
                      //         .toString(),
                      //     style: const TextStyle(fontSize: 25),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     controller.chooseDate();
                      //   },
                      //   child: const Text('Select Date'),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      Obx(() => ElevatedButton(
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                if (addPegawaiForm.currentState!.validate()) {
                                  await controller.tambahpegawai();
                                }
                              }
                            },
                            child: Text(
                              controller.isLoading.isFalse
                                  ? "Tambah Pegawai"
                                  : "Tunggu...",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          )),
                      // Obx(() => TextFormField(
                      //       onTap: () {
                      //         controller.selectDate();
                      //       },
                      //       initialValue: DateFormat('DD-MM- yyyy')
                      //           .format(controller.selectedDate.value)
                      //           .toString(),
                      //     )),
                    ],
                  ))
            ],
          ),
        ));
  }
}
