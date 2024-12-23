import 'package:flutter/material.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/NetworkModelfm/StockCheck_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class StockCheckReport extends StatefulWidget {
  String? outletId;
  String? empId;
  String? date;
  StockCheckReport(this.outletId, this.empId, this.date, {super.key});

  @override
  State<StockCheckReport> createState() => _StockCheckReportState();
}

class _StockCheckReportState extends State<StockCheckReport> {
  String? userName;
  String? emp;
  String? outletId;
  String? empId;
  String? date;

  List<String> produNames = [];
  var myList = [];
  int lengthlist = 0;

  StockCheckModel? _stockCheckReportModel;

  loadVals() async {
    await _fetchPrefVals();
  }

  _fetchPrefVals() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs1.get("user").toString();
      emp = prefs1.get("id").toString();
    });
    _getStockCheckReport();
  }

  _getStockCheckReport() async {
    print(
        "Inside the function - Outlet Id : $outletId, Employee Id : $emp, Date : $date");
    await ApiService.service
        .stockReport(context, outletId, emp, date)
        .then((value) => {
              setState(() {
                _stockCheckReportModel = value;
                myList.addAll(_stockCheckReportModel!.data);
                lengthlist = myList.length;
                print("The Count: $lengthlist");
              }),
              for (int i = 0; i < lengthlist; i++)
                {
                  produNames.add(_stockCheckReportModel!.data[i].productName),
                  // isAvail.add(_availabilityModel!.data![i].isAvailable!),
                },
              // print("The is available values : $isAvail"),
              print(produNames),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVals();
    outletId = widget.outletId;
    date = widget.date;

    // _getavailability();
    // _tabController = TabController(length: 2, vsync: this);
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
            const Text("Stock Check Report"),
            userName!.isNotEmpty
                ? Text(
                    "$userName - ($emp) - v "+AppVersion.version,
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(outletId!),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue[100],
                child: ListView.builder(
                    itemCount: lengthlist,
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          "The Length of out of stock items array : $lengthlist");
                      return Card(
                        elevation: 0,
                        color: Colors.orange[100],
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), //<-- SEE HERE
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _stockCheckReportModel!
                                        .data[index].productName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Refill Date : ${_stockCheckReportModel!.data[index].refillDate}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Refill Quantity : ${_stockCheckReportModel!.data[index].amount}"),
                                ],
                              )),
                          // "${_availabilityModel!.data![index].productId!}"),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
