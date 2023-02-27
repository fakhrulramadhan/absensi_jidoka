import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbsensiOnlineController extends GetxController {
  //TODO: Implement AbsensiOnlineController

  final count = 0.obs;

  //inisiasi dulu
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Completer<GoogleMapController> gMapCompleter = Completer();

  final kGooglePlex = const CameraPosition(
    target: LatLng(-3.1500193, 112.0552905),
    zoom: 5,
  );

  void onGmapCreated(GoogleMapController gMapCtrl) {
    gMapCompleter.complete(gMapCtrl);
    update();
  }

  Future<void> getcurrentLocation() async {
    try {
      //final position = await Geolocator.getCurrentPosition();

      Map<String, dynamic> dataResponseposition = await determinePosition();

      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services atau GPs are enabled/ nyala.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar("Error", "Harap nyalakan GPS terlebih dahulu",
            backgroundColor: Colors.red, colorText: Colors.white);
      }

      if (!dataResponseposition["error"]) {
        Position position = dataResponseposition["position"];

        final latitudes = position.latitude;
        final longitudes = position.longitude;

        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitudes, longitudes);

        //dapatkan alamat lokasi akurtnya
        String address =
            "${placemarks[0].name}, ${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].country}";
      }
    } catch (e) {}
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //return Future.error('Location services are disabled.');
      return {
        "message": "Tidak dapat mengambil GPS dari perangkat ini",
        "error": false
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //return Future.error('Location permissions are denied');
        Get.snackbar("Error", "Anda perlu menyalakan GPS terlebih dahulu",
            backgroundColor: Colors.red, colorText: Colors.white);
        return {"message": "Izin menggunakan GPS ditolak", "error": false};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Anda perlu menyalakan GPS terlebih dahulu",
          backgroundColor: Colors.red, colorText: Colors.white);
      return {
        "message":
            "Settingan hp nda tidak memperbolehkan utk mmmengakses GPS /n harap diubah pada settingannya",
        "error": false
      };
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition(); //dapat positionnya

    //secara default location accuracynya pakai yang best
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high //tinggi akurasinya
        );
    //returnnya harus dalam bentuk mapping juga
    return {
      "position": position,
      "message": "Berhasi mendapatkan posisi perangkat",
      "error": false
    };
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    //masuk ke doc uid nya current user (where nya)
    await firestore.collection("pegawai").doc(uid).update({
      //field position tipenya mapping (update posisi)
      "position": {"lat": position.latitude, "long": position.longitude},
      "address": address
    });
  }

  void increment() => count.value++;
}
