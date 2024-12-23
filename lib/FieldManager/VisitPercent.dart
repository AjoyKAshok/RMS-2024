import 'package:flutter/material.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Skipped_model.dart' as skipped;
import 'package:rms/NetworkModelfm/Visited_model.dart';

class VisitPercent extends StatefulWidget {
  Data? data;
  skipped.Data? pendingData;
  String emp = "";
  int? index;
  VisitPercent(this.emp, this.index, {super.key});

  @override
  State<VisitPercent> createState() =>
      _VisitPercentState(data, pendingData, emp, index);
}

class _VisitPercentState extends State<VisitPercent> {
  int i = 0;
  Data? data;
  skipped.Data? pendingData;
  String emp = "";
  int lengthlist = 0;
  int listLength = 0;
  int listPending = 0;
  int totalStores = 0;
  double visitPercent = 0;
  String percentVal = "";
  var myList = [];
  var visitedList = [];
  var pendingList = [];
  var date = DateTime.timestamp();
  VisitedModel? _data;
  skipped.SkippedModel? _pendingData;
  _VisitPercentState(
      Data? data, skipped.Data? pendingData, this.emp, this.index);
  int? index;

  _gettodayvisited(String emp) async {
    print("Emp Id for Visited : $emp");
    await ApiServices.service.visited(context, emp).then((value) => {
          // print("Value : ${value.data![0].storeName}"),
          print("Details of the Emp Id : $emp"),
          setState(() {
            _data = value;
            visitedList.addAll(_data!.data!);
            listLength = visitedList.length;
            print("Visited Stores Count : $listLength");
          })
        });
    // print("My List : ${_data!.data!.length}");

    for (var i = 0; i < listLength; i++) {
      visitedList.add(_data!.data![i].storeName);
    }
  }

  _getskipped(String emp) async {
    print("Emp Id for Skip : $emp");
    await ApiServices.service.skipped(context, emp).then((value) => {
          setState(() {
            _pendingData = value;
            pendingList.addAll(_pendingData!.data!);
            listPending = pendingList.length;
            print("Pending Stores Count : $listPending");
          })
        });
    for (var i = 0; i < listPending; i++) {
      pendingList.add(_pendingData!.data![i].storeName);
    }
  }

  totalOutlets() async {
    await _gettodayvisited(emp);
    await _getskipped(emp);
    setState(() {
      totalStores = listLength + listPending;
      visitPercent = totalStores != 0 ?(listLength / totalStores) * 100 : 0.0;
      percentVal = visitPercent.toStringAsFixed(2);
      print("Total Store Count : $totalStores");
    });
  }

  @override
  initState() {
    emp = widget.emp;
    print("The passed on Emp Id  : $emp");

    super.initState();

    totalOutlets();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: visitPercent <= 25.0
            ? Colors.red
            : visitPercent > 25.0 && visitPercent <= 50.0
                ? Colors.orange[300]
                : visitPercent > 50.0 && visitPercent <= 75.0
                    ? Colors.blue[300]
                    : Colors.green[300],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Visit %",
              style: TextStyle(
                  color: Colors.white.withOpacity(.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              "$percentVal%",
              style: TextStyle(
                  color: Colors.white.withOpacity(.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
