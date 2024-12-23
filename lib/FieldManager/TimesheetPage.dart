import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/PendingPage.dart';
import 'package:rms/FieldManager/TimesheetDetails.dart';
import 'package:rms/FieldManager/VisitPercent.dart';
import 'package:rms/FieldManager/VisitedPage.dart';
import 'package:rms/NetworkModelfm/Merchandiser_model.dart';
import 'package:rms/NetworkModelfm/Visited_model.dart' as vm;
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class TimeSheetPage extends StatefulWidget {
  Data? data;

  TimeSheetPage({super.key});
  @override
  State<TimeSheetPage> createState() => _TimeSheetPageState(data);
}

class _TimeSheetPageState extends State<TimeSheetPage> {
  int i = 0;
  Data? data;
  int lengthlist = 0;
  int listLength = 0;
  var myList = [];
  var visitedList = [];
  var date = DateTime.timestamp();
  String emp = "";
  String user = "";
  MerchandiserModel? _data;
  _TimeSheetPageState(Data? data);
  vm.VisitedModel? _visitData;
  _gettodayplanned() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    // emp=prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    context.loaderOverlay.show();
    ApiServices.service
        .merchandiser(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
              })
            });
  }

  // _gettodayvisited(String emp1) async {
  //   await ApiServices.service.visited(context, emp1).then((value) => {
  //         // print("Value : ${value.data![0].storeName}"),
  //         print("Details of the Emp Id : $emp1"),
  //         setState(() {
  //           _visitData = value;
  //           visitedList.addAll(_visitData!.data!);
  //           listLength = visitedList.length;
  //           print("Visited Stores Count : $listLength");
  //         })
  //       });
  //   // print("My List : ${_data!.data!.length}");

  //   for (var i = 0; i < listLength; i++) {
  //     visitedList.add(_visitData!.data![i].storeName);
  //   }
  // }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  @override
  initState() {
    super.initState();
    _gettodayplanned();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Time Sheet"),
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Pattern.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: const Color(0xfff5e1d5),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Outlet Name',
                      hintStyle: TextStyle(
                        color: Color(0XFFE84201),
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0XFFE84201),
                        size: 30,
                      ),
                      suffixIcon: Icon(
                        Icons.clear,
                        color: Color(0XFFE84201),
                        size: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lengthlist,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // _gettodayvisited(
                      //     _data!.data![index].employeeId.toString());
                      print(
                          "THe EmpId val : ${_data!.data![index].employeeId.toString()}");
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimeSheetDetails(
                                    _data!.data![index].firstName.toString(),
                                    _data!.data![index].employeeId.toString())),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), //<-- SEE HERE
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _data!.data![index].firstName
                                            .toString(),
                                        style: TextStyle(
                                            color: const Color(0XFFE84201)
                                                .withOpacity(.8),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Emp ID : ${_data!.data![index].employeeId}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                      //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 90,
                                    // color: Colors.orange[100],
                                    child: VisitPercent(_data!.data![index].employeeId
                                                  .toString(), index)
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text("Visited : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),),
                                      Row(
                                        children: [
                                          //  Text("Pending : 0",style: TextStyle(color: Color(0XFFE84201).withOpacity(.8),fontWeight: FontWeight.w400,fontSize: 13),),
                                          VisitedPage(
                                              _data!.data![index].employeeId
                                                  .toString(),
                                              index),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          //  Text("Pending : 0",style: TextStyle(color: Color(0XFFE84201).withOpacity(.8),fontWeight: FontWeight.w400,fontSize: 13),),
                                          PendingPage(
                                              _data!.data![index].employeeId
                                                  .toString(),
                                              index),
                                        ],
                                      ),
                                      //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
