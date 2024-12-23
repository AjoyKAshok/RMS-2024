import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/FieldManager/AvailabilityReport.dart';
import 'package:rms/FieldManager/StockCheckReport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../Employee/version.dart';

class ReportsDetailPage extends StatefulWidget {
  String? storeName;
  String? checkinDate;
  String? checkinType;
  String? checkinTime;
  String? checkoutTime;
  String? employeeName;
  String? ciLoc;
  String? coLoc;
  String? timeSheetId;
  String? empId;
  String? outletId;

  ReportsDetailPage(
      this.storeName,
      this.checkinDate,
      this.checkinType,
      this.checkinTime,
      this.checkoutTime,
      this.employeeName,
      this.ciLoc,
      this.coLoc,
      this.timeSheetId,
      this.empId,
      this.outletId,
      {super.key});

  @override
  State<ReportsDetailPage> createState() => _ReportsDetailPageState();
}

class _ReportsDetailPageState extends State<ReportsDetailPage> {
  String userName = "";
  String emp = "";
  String? storeName;
  String? checkedinDate;
  String? checkinType;
  String? checkinTime;
  String? checkoutTime;
  String? employeeName;
  String? checkInLoc;
  String? checkOutLoc;
  String? timeSheetId;
  String? empId;
  String? outletId;
  Duration difference = Duration();
  Duration workingHours = Duration();

  _fetchPrefVals() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs1.get("user").toString();
      emp = prefs1.get("id").toString();
    });
  }

  Duration calculateDifference(String? startDay, String? endDay) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime1 = format.parse(startDay!);
    DateTime dateTime2 = format.parse(endDay!);

    setState(() {
      difference = dateTime2.difference(dateTime1);
    });

    return difference;
  }

  getVals(String? inTime, String? outTime) async {
    setState(() {      
      workingHours = calculateDifference(inTime, outTime);
    });
  }

  @override
  initState() {
    super.initState();
    _fetchPrefVals();
    storeName = widget.storeName;
    checkedinDate = widget.checkinDate;
    checkinType = widget.checkinType;
    checkinTime = widget.checkinTime;
    checkoutTime = widget.checkoutTime;
    employeeName = widget.employeeName;
    checkInLoc = widget.ciLoc;
    checkOutLoc = widget.coLoc;
    timeSheetId = widget.timeSheetId;
    empId = widget.empId;
    outletId = widget.outletId;
    getVals(checkinTime, checkoutTime);
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
            const Text("Detailed Report Page"),
            userName.isNotEmpty
                ? Text(
                    "$userName - ($emp)  - v " + AppVersion.version,
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Pattern.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("images/Pattern.png"),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: const Color(0xfff5e1d5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 330,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                storeName!,
                                style: const TextStyle(
                                    color: Color(0XFFE84201),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Check In Date : $checkedinDate",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              // const SizedBox(
                              //   height: 2,
                              // ),
                              // Text(
                              //   "Visit Type : $checkinType",
                              //   style: const TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.w400,
                              //       fontSize: 14),
                              // ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "CheckIn Time : $checkinTime",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "CheckOut Time : $checkoutTime",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "CheckIn Locaction : $checkInLoc",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "CheckOut Location : $checkOutLoc",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Visited By : $employeeName - $empId",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                               const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Time Spent : $workingHours",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Merchandiser Activites",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 428.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => AvailabilityReport(timeSheetId)),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 175,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.00),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        "Availability",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) =>
                            StockCheckReport(outletId, emp, checkedinDate)),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 175,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.00),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        "Stock Check Details",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
