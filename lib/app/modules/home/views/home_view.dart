import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hitungongkir/app/modules/home/views/widget/city_view.dart';

import '../controllers/home_controller.dart';

import './widget/province_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
              child: Text(
                'Hitung Ongkir',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.green.shade500, Colors.green.shade600]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ]),
          ),
          preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ProvinceView(tipe: 'asal'),
            ),
            Obx(() => controller.hideKotaAsal.isTrue
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CityView(
                      provId: controller.provIdAsal.value,
                      tipe: 'asal',
                    ))
                : SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ProvinceView(tipe: 'tujuan'),
            ),
            Obx(() => controller.hideKotaTujuan.isTrue
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CityView(
                      provId: controller.provIdTujuan.value,
                      tipe: 'tujuan',
                    ))
                : SizedBox()),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  autocorrect: false,
                  controller: controller.beratInput,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Masukkan Berat",
                  ),
                  onChanged: (value) => controller.ubahBerat(value),
                )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  child: DropdownSearch<String>(
                    mode: Mode.BOTTOM_SHEET,
                    items: ["Kwintal", "Kg", "Ons", "Gram", "Mg"],
                    label: "Satuan",
                    selectedItem: "Gram",
                    onChanged: (value) => controller.ubahSatuan(value!),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
