import 'package:absensi_jidoka/app/modules/dashboard_utama/controllers/dashboard_utama_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_offline/flutter_offline.dart';

class LoginView extends GetView<LoginController> {
  final pageDu = Get.put(DashboardUtamaController());
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginForm = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 57, 230),
        // appBar: AppBar(
        //   // title: const Text('LoginView'),
        //   // centerTitle: true,
        //   backgroundColor: Colors.blue[200],

        // ),
        body:
            //pakai column kalau ukurannya childnya mau dicustomize
            //pakai singlecsview kalau widgetnya banyak
            OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: connected ? 0 : 1,
                      child: Container(
                        height: 30,
                        color: connected ? Colors.green : Colors.red,
                        child: Center(
                          child: Text(
                            connected ? "Online" : "Offline",
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 60.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       height: 40,
                  //       width: 40,
                  //       decoration: BoxDecoration(
                  //         // 1/2 from  height width
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Colors.purple,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20.0,
                  //     ),
                  //     Container(
                  //       height: 40,
                  //       width: 40,
                  //       decoration: BoxDecoration(
                  //         // 1/2 from  height width
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Colors.purple,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   width: 300,
                  //   height: 100,
                  //   child: Positioned(
                  //     top: 10,
                  //     left: 10,
                  //     child: Stack(
                  //       children: [
                  //         Positioned(
                  //           left: 25,
                  //           child: Container(
                  //             height: 80,
                  //             width: 80,
                  //             decoration: BoxDecoration(
                  //               // 1/2 from  height width
                  //               borderRadius: BorderRadius.circular(40),
                  //               color: Colors.green,
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           height: 40,
                  //           width: 40,
                  //           decoration: BoxDecoration(
                  //             // 1/2 from  height width
                  //             borderRadius: BorderRadius.circular(30),
                  //             color: Colors.purple,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const Text("Employee Self Service",
                      style: TextStyle(
                          color: Color.fromARGB(255, 204, 204, 204),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("PT. Jidoka System Indonesia",
                      style: TextStyle(
                          color: Color.fromARGB(255, 204, 204, 204),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                      height: 180,
                      width: 180,
                      //online,pakai lottie.network,  offline pakai asset
                      child: Center(
                          child: Lottie.asset("assets/login.json",
                              fit: BoxFit.contain))),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Form(
                      key: loginForm,
                      child: Column(
                        children: [
                          Container(
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                autocorrect: false, //matikan tulisan otomatis
                                controller: controller.emailC, //handling text
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor:
                                    const Color.fromARGB(255, 110, 139, 96),
                                onChanged: (value) {
                                  //
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email Wajib Diisi";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    fillColor:
                                        Color.fromARGB(255, 170, 228, 144),
                                    filled: true,
                                    focusColor: Colors.green,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.person),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                autocorrect: false, //matikan tulisan otomatis
                                controller:
                                    controller.passwordC, //handling text
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                cursorColor: Colors.blueGrey,
                                onChanged: (value) {
                                  //
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password Wajib Diisi";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 170, 228, 144),
                                    focusColor: Colors.green,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.lock),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Hero(
                          //   tag: "login_btn",
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.brown),
                          //     onPressed: () {
                          //       // controller.doGoogleLogin();
                          //       Get.toNamed(Routes.HOME);
                          //     },
                          //     child: Text(
                          //       "Login".toUpperCase(),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () async {
                              //Get.toNamed(Routes.DASHBOARD);
                              if (controller.isLoading.isFalse) {
                                if (loginForm.currentState!.validate()) {
                                  await controller.login();
                                }
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.green, Colors.yellow],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          // const SizedBox(height: 16.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: <Widget>[
                          //     const Text(
                          //       "Don???t have an Account ? ",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 10.0,
                          //     ),

                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const SizedBox(
            height: 1.0,
          ),
        ));
  }
}
