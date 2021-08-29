import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hitungongkir/app/modules/home/models/province_model.dart';

import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';

class ProvinceView extends GetView<HomeController> {
  const ProvinceView({
    Key? key,
    required this.tipe,
  }) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
        label: "Pilih Provinsi " + tipe.capitalize!,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          var response = await http
              .get(url, headers: {"key": "c4b129348707a3dc022068c3d68d8591"});

          var data = json.decode(response.body) as Map<String, dynamic>;

          var provinces = data["rajaongkir"]["results"] as List<dynamic>;

          var models = Province.fromJsonList(provinces);
          return models;
        },
        onChanged: (value) {
          if (value != null) {
            if (tipe == 'asal') {
              controller.hideKotaAsal.value = true;
              controller.provIdAsal.value = int.parse(value.provinceId!);
            } else {
              controller.hideKotaTujuan.value = true;
              controller.provIdTujuan.value = int.parse(value.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hideKotaAsal.value = false;
              controller.provIdAsal.value = 0;
            } else {
              controller.hideKotaTujuan.value = false;
              controller.provIdTujuan.value = 0;
            }
          }
        },
        showClearButton: true,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.province!,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: "Cari Provinsi ${tipe.capitalize}"));
  }
}
