import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rms/ClientNetworkModel/OOSModel.dart';
import 'package:rms/ClientRep/client_api_service.dart';
import 'package:rms/ClientRep/client_oos_page.dart';

class ClientOOS extends StatefulWidget {
  Data? data;
  String emp = "";
  String datePassed = "";
  // int? index;
  ClientOOS(this.emp, this.datePassed,
      // this.index,
      {super.key});

  @override
  State<ClientOOS> createState() => _ClientOOSState(data, emp, datePassed);
  // ,
  // index
}

class _ClientOOSState extends State<ClientOOS> {
  int i = 0;
  Data? data;
  String emp = "";
  String? empId;
  int lengthlist = 0;
  var myList = [];
  var visitedList = [];
  var date = DateTime.timestamp();
  OOSModel? _data;
  String? datePassed;
  var storesList = [];
  String theStore = '';
  int? index;
  int storeCount = 0;
  int visitedCount = 0;
  List<Map<String, dynamic>> itemNameList = [];
  List<Map<String, dynamic>> uniqueItemNameList = [];
  Map<String, dynamic>? currentStore;
  Map<String, dynamic>? uniqueStoreList;
  String currentStoreName = '';
  Map<String, List<String>> groupedProducts = {};

  _ClientOOSState(
    Data? data,
    this.emp,
    this.datePassed,
  );

  Map<String, List<String>> groupProductsByStore(
      List<Map<String, dynamic>> inputList) {
    for (var item in inputList) {
      String storeName = item['store_name'].trim();
      String productName = item['product_name'];

      if (!groupedProducts.containsKey(storeName)) {
        groupedProducts[storeName] = [];
      }

      groupedProducts[storeName]!.add(productName);
    }

    return groupedProducts;
  }

  _gettodayplanned() async {
    print("The EmpId in fetching planned : $emp");
    await ClientApiService.clientservice
        .clientoos(context, emp, datePassed)
        .then((value) => {
              // print("Value : ${value.data![0].storeName}"),
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
              })
            });
    // print("My List : ${_data!.data!.length}");
    for (var i = 0; i < lengthlist; i++) {
      visitedList.add(_data!.data![i].storeName);

      currentStore = {
        'store_name': _data!.data![i].storeName.toString(),
        "store_code": _data!.data![i].storeCode.toString(),
        "product_name": _data!.data![i].pName.toString(),
        "brand_name": _data!.data![i].bName.toString(),
        "category_name": _data!.data![i].cName.toString(),
        "brand_id": _data!.data![i].bId.toString(),
      };

      itemNameList.add(currentStore!);
    }

    Map<String, List<String>> result = groupProductsByStore(itemNameList);

    result.forEach((storeName, products) {
      print('Store: $storeName');
      for (var product in products) {
        print('  - $product');
      }
      print('');
    });
    print("The item name list : $itemNameList");
    for (var j = 0; j < visitedList.length; j++) {
      print("OOS List -$j : ${visitedList[j]}");
      theStore != visitedList[j] ? storesList.add(visitedList[j]) : null;
      theStore = visitedList[j];
    }
    storeCount = storesList.length;
    visitedCount = visitedList.length;
    log("The Current Store Map : $itemNameList");
    // log("The Unique Store Map : $uniqueItemNameList");
    print("The Current Store Map Length : ${itemNameList.length}");
    print("The Unique Store Map Length : $storeCount");
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    empId = widget.emp;
    _gettodayplanned();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ClientOOSPage(
                        widget.emp,
                        widget.datePassed,
                        index)),
              );
            },
            child: Text(
              "OOS Count : ",
              style: TextStyle(
                  color: const Color(0XFFE84201).withOpacity(.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientOOSPage(
                          widget.emp,
                          widget.datePassed,
                          index)),
                );
              },
              child: Text(
                lengthlist.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
