// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/NetworkModel/Availability_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class AvailabilityReport extends StatefulWidget {
  String? timeSheetId;
  AvailabilityReport(this.timeSheetId, {super.key});

  @override
  State<AvailabilityReport> createState() => _AvailabilityReportState();
}

class _AvailabilityReportState extends State<AvailabilityReport>
    with SingleTickerProviderStateMixin {
  String? userName;
  String? emp;
  String? timeSheetId;

  var filteredList = [];
  AvailabilityModel? _availabilityModel;
  int lengthlist = 0;
  late TabController _tabController;

  var myList = [];
  // List<bool> light = [];
  // List<String> items = [
  //   'Category',
  // ];
  List<String> outOfStockItems = [];
  List<String> items12 = [];
  List<String> items123 = [];
  List<String> produNames = [];
  List<String> isAvail = [];
  // var items1 = [
  //   'Brand',
  // ];
  // var items2 = [
  //   'Select\nReason',
  //   'Out of Stock',
  // ];

  loadVals() async {
    await _fetchPrefVals();
  }

  _fetchPrefVals() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs1.get("user").toString();
      emp = prefs1.get("id").toString();
    });
  }

  _getavailability() async {
    outOfStockItems.clear();
    await ApiService.service
        .availability(context, timeSheetId)
        .then((value) => {
              setState(() {
                _availabilityModel = value;
                myList.addAll(_availabilityModel!.data!);
                lengthlist = myList.length;
                print("The Count: $lengthlist");
              }),
              for (int i = 0; i < lengthlist; i++)
                {
                  produNames.add(_availabilityModel!.data![i].pName!),
                  // isAvail.add(_availabilityModel!.data![i].isAvailable!),
                },
              print("The is available values : $isAvail"),
              print(produNames),
              for (int i = 0; i < lengthlist; i++)
                {
                  // _availabilityModel!.data![i].isAvailable != null &&
                          _availabilityModel!.data![i].isAvailable == "0"
                      ? outOfStockItems.add(_availabilityModel!.data![i].pName!)
                      : null
                },
              print("The Out of Stock Items : $outOfStockItems"),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVals();
    timeSheetId = widget.timeSheetId;
    _getavailability();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Availability Report"),
            userName!.isNotEmpty
                ? Text(
                    "$userName - ($emp) - v"+AppVersion.version,
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0XFFE84201),
          indicatorColor: const Color(0XFFE84201),
          tabs: const [
            Tab(text: "INS"),
            Tab(text: "OOS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Products SKU (ZREP)"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: ListView.builder(
                        itemCount: lengthlist,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 0,
                            color: Colors.orange[100],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), //<-- SEE HERE
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(_availabilityModel!.data![index].pName!),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Products SKU (ZREP)"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: outOfStockItems.isEmpty
                        ? const Center(
                            child: Card(
                              child: Text("No Items to Display"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: outOfStockItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(
                                  "The Length of out of stock items array : ${outOfStockItems.length}");
                              return Card(
                                elevation: 0,
                                color: Colors.orange[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.0), //<-- SEE HERE
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${outOfStockItems[index]}"),
                                  // "${_availabilityModel!.data![index].productId!}"),
                                ),
                              );
                            }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
