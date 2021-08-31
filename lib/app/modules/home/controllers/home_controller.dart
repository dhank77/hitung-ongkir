import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final hideKotaAsal = false.obs;
  final provIdAsal = 0.obs;
  final hideKotaTujuan = false.obs;
  final provIdTujuan = 0.obs;

  double berat = 0.0;
  String satuan = "gram";
  late TextEditingController beratInput;

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    convertBerat(cekSatuan);
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratInput.text) ?? 0.0;
    convertBerat(value);
    satuan = value;
  }

  void convertBerat(String convert) {
    switch (convert) {
      case "Kwintal":
        berat = berat * 100000;
        break;
      case "Kg":
        berat = berat * 1000;
        break;
      case "Ons":
        berat = berat * 100;
        break;
      case "Gram":
        berat = berat;
        break;
      case "Mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
  }

  @override
  void onInit() {
    beratInput = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    beratInput.dispose();
    super.dispose();
  }
}
