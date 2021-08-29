import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hitungongkir/app/modules/home/models/city_model.dart';

import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';

class CityView extends GetView<HomeController> {
  const CityView({
    Key? key,
    required this.tipe,
    required this.provId,
  }) : super(key: key);

  final String tipe;
  final int provId;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
        label: "Pilih Kota " + tipe.capitalize!,
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${provId}");
          var response = await http
              .get(url, headers: {"key": "c4b129348707a3dc022068c3d68d8591"});

          var data = json.decode(response.body) as Map<String, dynamic>;

          var provinces = data["rajaongkir"]["results"] as List<dynamic>;

          var models = City.fromJsonList(provinces);
          return models;
        },
        onChanged: (value) => value!.cityName,
        showClearButton: true,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "${item.cityName}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.cityName!,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: "Cari Kota ${tipe.capitalize}"));
  }
}
