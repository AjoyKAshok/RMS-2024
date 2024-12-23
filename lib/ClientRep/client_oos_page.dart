// import 'dart:async';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rms/ClientNetworkModel/OOSModel.dart';
import 'package:rms/ClientRep/client_api_service.dart';
import 'package:rms/ClientRep/client_outofstock.dart';
import 'package:rms/Employee/version.dart';

class ClientOOSPage extends StatefulWidget {
  Data? data;
  String emp = "";
  String datePassed = "";
  int? index;
  ClientOOSPage(this.emp, this.datePassed, this.index, {super.key});

  @override
  State<ClientOOSPage> createState() => _ClientOOSPageState();
}

class _ClientOOSPageState extends State<ClientOOSPage> {
  // Timer? _timer;
  int i = 0;
  Data? data;
  int lengthlist = 0;
  int storeLengthList = 0;
  int listLength = 0;
  var myList = [];
  var myStoreList = [];
  var visitedList = [];
  var date = DateTime.timestamp();

  String emp = "";
  String user = "";
  // MerchandiserModel? _data;
  // _TimeSheetPageState(Data? data);
  // vm.VisitedModel? _visitData;

  int storeCount = 0;
  int visitedCount = 0;
  List<Map<String, dynamic>> itemNameList = [];
  List<Map<String, dynamic>> uniqueItemNameList = [];
  Map<String, dynamic>? currentStore;
  Map<String, dynamic>? uniqueStoreList;
  String currentStoreName = '';
  Map<String, List<String>> groupedProducts = {};
  OOSModel? _datao;
  String? datePassed;
  var storesList = [];
  String theStore = '';

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

  _gettodayplannedStores(String empId, String datePassedIn) async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
    });
    print("The EmpId in fetching planned : $empId");
    await ClientApiService.clientservice
        .clientoos(context, empId, datePassedIn)
        .then((value) => {
              // print("Value : ${value.data![0].storeName}"),
              setState(() {
                _datao = value;
                value.status == 200
                    ? myStoreList.addAll(_datao!.data!)
                    : myStoreList = [];
                storeLengthList = myStoreList.length;
              }),
              print("Store Length List is : $storeLengthList"),
            });
    // print("My List : ${_data!.data!.length}");
    for (var i = 0; i < storeLengthList; i++) {
      visitedList.add(_datao!.data![i].storeName);

      currentStore = {
        'store_name': _datao!.data![i].storeName.toString(),
        "store_code": _datao!.data![i].storeCode.toString(),
        "product_name": _datao!.data![i].pName.toString(),
        "brand_name": _datao!.data![i].bName.toString(),
        "category_name": _datao!.data![i].cName.toString(),
        "brand_id": _datao!.data![i].bId.toString(),
      };

      itemNameList.add(currentStore!);
    }
    print("Visited Length : ${visitedList.length}");
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
    print("Length of Store List is : ${storesList.length}");
  }

  @override
  initState() {
    super.initState();

    _gettodayplannedStores(widget.emp, widget.datePassed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ClientOutOfStockDetails()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0XFF909090),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Out Of Stock Details Page"),
            Text(
              "$user($emp) - v ${AppVersion.version}",
              style: TextStyle(
                  color: Colors.black.withOpacity(.6),
                  fontSize: 8,
                  fontWeight: FontWeight.w500),
            ),
          ],
      ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "OOS Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              storeLengthList > 0
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.orange.shade100,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: storesList.length,
                          itemBuilder: (context, index) {
                            String storeName =
                                groupedProducts.keys.elementAt(index);
                            List<String> products = groupedProducts[storeName]!;
                            return ExpansionTile(
                              title: Text(
                                storeName,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange),
                              ),
                              children: products
                                  .map((product) => ListTile(
                                    // selectedColor: Colors.orange.shade50,
                                          title: Text(
                                        product,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )))
                                  .toList(),
                            );
                          },
                        ),
                      ),
                  )
                  : const SizedBox(),
              const SizedBox(
                height: 10.00,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
