import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/ClientNetworkModel/ReplenishDetailModel.dart';
import 'package:rms/ClientNetworkModel/StoreProduct.dart';
import 'package:rms/ClientRep/client_api_service.dart';
import 'package:rms/ClientRep/client_home.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientReplenishDetails extends StatefulWidget {
  const ClientReplenishDetails({super.key});

  @override
  State<ClientReplenishDetails> createState() => _ClientReplenishDetailsState();
}

class _ClientReplenishDetailsState extends State<ClientReplenishDetails> {
  // Timer? _timer;
  int i = 0;
  Data? data;
  int lengthlist = 0;
  int storeLengthList = 0;
  int listLength = 0;
  var myList = [];
  var myStoreList = [];
  var visitedList = [];
  var date = DateTime.now();

  String emp = "";
  String user = "";

  int storeCount = 0;
  int visitedCount = 0;
  List<Map<String, dynamic>> itemNameList = [];
  List<Map<String, dynamic>> uniqueItemNameList = [];
  Map<String, dynamic>? currentStore;
  Map<String, dynamic>? uniqueStoreList;
  String currentStoreName = '';
  Map<String, List<String>> groupedProducts = {};
  Map<String, List<dynamic>> groupedByStoreName = {};
  var resp;
  ReplenishDetailModel? _data;
  String? datePassed;
  var storesList = [];
  String theStore = '';

  DateTime selectedDate = DateTime.now();
  String? dateToUse;
  String? todayDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
        print("The selected date is : $dateToUse");
        print("Todays Date : $todayDate");
        _gettodayplannedRefresh(dateToUse!);
        myList = [];
        lengthlist = 0;
      });
      // todayDate == dateToUse
      //     ? _startPeriodicUpdates() // print("Same Date")
      //     : _timer!.cancel();
      // await _gettodayplannedrefresh();
      // Here you can call a method to refresh data based on the new date
      // For example: _refreshDataForDate(selectedDate);
    }
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    // SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
      dateToUse = DateFormat('yyyy-MM-dd').format(date).toString();
    });
    await Future.delayed(const Duration(seconds: 3));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
      dateToUse = DateFormat('yyyy-MM-dd').format(date).toString();
    });
  }

  Map<String, Map<String, List<StoreData>>> groupedData = {};

  void processData(List<Map<String, dynamic>> rawData) {
    // Convert raw data to StoreData objects
    List<StoreData> dataList =
        rawData.map((item) => StoreData.fromMap(item)).toList();

    // Group by store name
    Map<String, Map<String, List<StoreData>>> tempGrouped = {};

    for (var item in dataList) {
      // Initialize store if not exists
      if (!tempGrouped.containsKey(item.storeName)) {
        tempGrouped[item.storeName] = {};
      }

      // Initialize employee if not exists
      if (!tempGrouped[item.storeName]!.containsKey(item.category)) {
        tempGrouped[item.storeName]![item.category] = [];
      }

      // Add product to employee's list
      tempGrouped[item.storeName]![item.category]!.add(item);
    }

    setState(() {
      groupedData = tempGrouped;
    });
  }

  Map<String, List<String>> groupProductsByStore(
      List<Map<String, dynamic>> inputList) {
    for (var item in inputList) {
      String storeName = item['store_name'].trim();
      String productName = item['category'];

      // String productName = item['product_name'] + " " + item['emp_id'];

      if (!groupedProducts.containsKey(storeName)) {
        groupedProducts[storeName] = [];
        print("Grouped Products : $groupedProducts");
      }

      groupedProducts[storeName]!.add(productName);
    }

    return groupedProducts;
  }

  _gettodayplanned(String datePassedIn) async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
      dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
    });

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    // emp=prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    context.loaderOverlay.show();

    ClientApiService.clientservice
        .clientreplenish(context, dateToUse)
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data);
                lengthlist = myList.length;

                todayDate = DateFormat('yyyy-MM-dd').format(date).toString();

                for (var i = 0; i < lengthlist; i++) {
                  visitedList.add(_data!.data[i].storeName);

                  currentStore = {
                    'store_name': _data!.data[i].storeName.toString(),
                    "store_code": _data!.data[i].storeCode.toString(),
                    "product_name": _data!.data[i].pName.toString(),
                    "brand_name": _data!.data[i].bName.toString(),
                    "category_name": _data!.data[i].cName.toString(),
                    "brand_id": _data!.data[i].bId.toString(),
                    "emp_id": _data!.data[i].employeeId.toString(),
                    "emp_name": _data!.data[i].employeeName.toString(),
                    "check_in": _data!.data[i].checkInTimestamp.toString(),
                    "check_out": _data!.data[i].checkOutTimestamp.toString(),
                    "sku": _data!.data[i].sku.toString(),
                    "amount": _data!.data[i].amount.toString(),
                    "category": _data!.data[i].category.toString(),
                  };

                  itemNameList.add(currentStore!);
                }
                processData(itemNameList);

                storeCount = storesList.length;
                visitedCount = visitedList.length;
                log("The Current Store Map : $itemNameList");
                // log("The Unique Store Map : $uniqueItemNameList");
                print("The Current Store Map Length : ${itemNameList.length}");
                print("The Unique Store Map Length : $storeCount");
                setState(() {});
              })
            });
    // _gettodayplannedStores();
  }

  _gettodayplannedRefresh(String datePassedIn) async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
      dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
    });

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    // emp=prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    // context.loaderOverlay.show();
    ClientApiService.clientservice
        .clientreplenish(context, datePassedIn)
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data);
                lengthlist = myList.length;
                print(" Json Decoded Data : ${value.toJson()}");

                // todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
                for (var i = 0; i < lengthlist; i++) {
                  visitedList.add(_data!.data[i].storeName);

                  currentStore = {
                    'store_name': _data!.data[i].storeName.toString(),
                    "store_code": _data!.data[i].storeCode.toString(),
                    "product_name": _data!.data[i].pName.toString(),
                    "brand_name": _data!.data[i].bName.toString(),
                    "category_name": _data!.data[i].cName.toString(),
                    "brand_id": _data!.data[i].bId.toString(),
                    "emp_id": _data!.data[i].employeeId.toString(),
                    "emp_name": _data!.data[i].employeeName.toString(),
                    "check_in": _data!.data[i].checkInTimestamp.toString(),
                    "check_out": _data!.data[i].checkOutTimestamp.toString(),
                    "sku": _data!.data[i].sku.toString(),
                    "amount": _data!.data[i].amount.toString(),
                    "category": _data!.data[i].category.toString(),
                  };

                  itemNameList.add(currentStore!);
                }
                processData(itemNameList);

                storeCount = storesList.length;
                visitedCount = visitedList.length;
                log("The Current Store Map : $itemNameList");
                // log("The Unique Store Map : $uniqueItemNameList");
                print("The Current Store Map Length : ${itemNameList.length}");
                print("The Unique Store Map Length : $storeCount");
                setState(() {});
              })
            });
    // _gettodayplannedStores();
  }

  @override
  initState() {
    todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
    super.initState();
    loader();
    _gettodayplanned(todayDate!);
    // _startPeriodicUpdates();
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        leading: IconButton(
          onPressed: () {
            // _timer!.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientHome()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0XFF909090),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Replenish Details"),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Pattern.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Selected Date: $dateToUse',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFE84201),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                            print("Todays Date : $todayDate");
                            print("Selected Date : $dateToUse");
                            // if (todayDate!.compareTo(dateToUse!) != 0) {
                            //   _timer!.cancel();
                            // }
                            // todayDate != dateToUse ? _timer!.cancel() : null;
                            // todayDate == dateToUse
                            //     ? print("Same Date")
                            //     : _timer!.cancel();
                            setState(() {});
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  groupedData.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: groupedData.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                "THe EmpId val : ${_data!.data[index].employeeId}");
                            

                            String storeName =
                                groupedData.keys.elementAt(index);
                            // String checkInStamp = groupedData
                            //     .values.first.entries.first.value.first.checkIn;
                            Map<String, List<StoreData>> employeeData =
                                groupedData[storeName]!;
                            // print("Check In Stamp : $storeName -  ${employeeData.entries.map((e) => e.value.first.checkIn)}");
                            var lastCheckIn = employeeData.entries.last.value.first.checkIn;
print("Last Check-in: $lastCheckIn");
var lastCheckOut = employeeData.entries.last.value.first.checkOut;
print("Last Check-in: $lastCheckOut");
                            
                            return Card(
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  ExpansionTile(
                                    title: Text(
                                      storeName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange),
                                    ),
                                    subtitle: Text(
                                      'Check In: $lastCheckIn\nCheck Out: $lastCheckOut',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    children: employeeData.entries
                                        .map((employeeEntry) {
                                      String empId = employeeEntry.key;

                                      List<StoreData> products =
                                          employeeEntry.value;
                                      String empName = products.first.category;
                                      // String quantity = products.first.amount;

                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 4.0),
                                        child: ExpansionTile(
                                          // collapsedTextColor: Colors.blue.shade700,
                                          title: Text(
                                            '$empName : ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          // subtitle: Text(
                                          //   'Check In: ${products.first.checkIn}\nCheck Out: ${products.first.checkOut}',
                                          //   style:
                                          //       const TextStyle(fontSize: 12),
                                          // ),
                                          children: products
                                              .map((product) => ListTile(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          product.productName,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange
                                                                  .shade700),
                                                        ),
                                                        Text(
                                                          product.amount,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .orange
                                                                  .shade700),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                      'Item Type: ${product.sku}',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange.shade700),
                                                    ),
                                                    dense: true,
                                                  ))
                                              .toList(),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ]),
                              ),
                            );
                          })
                      : const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child:
                                  Text("No Replenishments Done for the day..."),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
