import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/FieldManager/AddWeekPage.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/JourneyDetails.dart';
import 'package:rms/FieldManager/SelectOutlets.dart';
import 'package:rms/FieldManager/Selectmerchandiser.dart';
import 'package:rms/NetworkModelfm/Merchandiser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Employee/version.dart';

class JourneyManager extends StatefulWidget {
  Data? data;
  String j = "";
  JourneyManager(this.j, {super.key});
  @override
  State<JourneyManager> createState() => _JourneyManagerState(data, j);
}

class _JourneyManagerState extends State<JourneyManager> {
  int i = 0;
  int l = 0;
  int m = 0;
  String j = "";
  String merch = "";
  String merch1 = "";
  String empName = "";
  String empName1 = "";
  String out = "Select Outlets";
  String out2 = "Select Outlets";
  String stores = "Select Outlets";
  String stores1 = "Select Outlets";
  String userName = "";
  String emp = "";
  List<int> let = [];
  List<int> let1 = [];
  List<String> out1 = [];
  List<String> out3 = [];
  final TextEditingController _searchController = TextEditingController();
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var date = DateTime.timestamp();
  DateTime now = DateTime.now();
  MerchandiserModel? _data;
  _JourneyManagerState(Data? data, this.j);
  String _selectedDate = '';
  var day = [];
  var month = [];
  var intMonth = [];
  String selectedMonths = '';
  String? thisYear;
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List<Map<String, dynamic>> customMerchList = [];
  Map<String, dynamic>? currentMerch;
  // String month = 'Select Month';
  late String selectedDays;
  var filteredList = [];
  var filteredList1 = [];
  String? empFN;
  String? empMN;
  String? empSN;
  bool searchStarted = false;
  bool saveClicked = false;
  List<bool> _isChecked = [false, false, false, false, false, false, false];
  List<bool> _isMonthChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  final List<String> _texts = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  final List<String> _months = [
    "January",
    "Februay",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  _gettodayplanned() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    await ApiServices.service
        .merchandiser(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
                for (int i = 0; i < lengthlist; i++) {
                  filteredList.add(
                      "${_data!.data![i].employeeId} - ${_data!.data![i].firstName}");
                  empFN = _data!.data![i].firstName ?? "";
                  empMN = _data!.data![i].middleName ?? "";
                  empSN = _data!.data![i].surname ?? "";
                  currentMerch = {
                    'emp_name': "$empFN  $empMN  $empSN ",
                    'emp_id': _data!.data![i].employeeId,
                    'filter_name':
                        '$empFN + $empMN + $empSN + ${_data!.data![i].employeeId}',
                  };
                  customMerchList.add(currentMerch!);
                }
                print("The Merch List : $customMerchList");
              })
            });
  }

  void _filterMerch(String query) {
    var results = [];
    if (query.isEmpty) {
      results = filteredList;
    } else {
      results = customMerchList.where((item) {
        return item['filter_name'].toLowerCase().contains(query);
      }).toList();
    }

    setState(() {
      filteredList1 = results;
    });
    print("The filtered Merch List : $filteredList1");
  }

  String formatStoreNames(String storeNames) {
    // Split the string by commas and join with newline characters
    return storeNames.split(', ').join('\n');
  }

  String formatDayss(String days) {
    // Split the string by commas and join with newline characters
    return days.split(', ').join('\n');
  }

  String formatMonths(String months) {
    // Split the string by commas and join with newline characters
    return months.split(', ').join('\n');
  }

  _refresh() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      j == "1" ? i = 0 : i = 1;
      merch = prefs1.get("merch").toString();
      merch1 = prefs1.get("merch1").toString();
      print("Value of merch : $merch");
      empName = prefs1.get("empName").toString();
      empName1 = prefs1.get("empName1").toString();
      print("The Merchandiser Name Fetched from Shared Preferences : $empName");
      out = prefs1.get("out").toString() == ""
          ? out
          : prefs1.get("out").toString();
      out == "Select Outlets" ? "Select Outlets" : l = out.length;
      l == 0 ? l = 0 : out1 = out.substring(1, (l - 1)).split(',');
      out1 == [] ? "" : let = out1.map(int.parse).toList();
      Preference.setOutlets([]);
      stores = prefs1.get("store").toString();
      print("The selected stores : $stores");
    });
  }

  _refresh1() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      j == "1" ? i = 0 : i = 1;
      out2 = prefs1.get("out1").toString() == ""
          ? out2
          : prefs1.get("out1").toString();
      out2 == "Select Outlets" ? "Select Outlets" : m = out2.length;
      m == 0 ? m = 0 : out3 = out2.substring(1, (m - 1)).split(',');
      out3 == [] ? "" : let1 = out3.map(int.parse).toList();
      Preference.setOutlets1([]);
      stores1 = prefs1.get("store1").toString();
      print("The selected stores : $stores1");
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  initState() {
    super.initState();
    _gettodayplanned();
    thisYear = now.year.toString();
    print("The Current Year is : $thisYear");
    _refresh();
    _refresh1();
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 3,
            backgroundColor: const Color(0xfff5e1d5),
            foregroundColor: const Color(0XFFE84201),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Journey Plans"),
                userName.isNotEmpty
                    ? Text(
                        "$userName($emp) - New Version ${AppVersion.version}",
                        style:
                            const TextStyle(fontSize: 9, color: Colors.black),
                      )
                    : const Text(""),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        color: Colors.white,
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                          indicatorColor: const Color(0XFFE84201),
                          labelColor: const Color(0XFFE84201),
                          labelStyle: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabAlignment: TabAlignment.fill,
                          isScrollable: false,
                          tabs: [
                            const Tab(
                              text: "Journey Plan Details",
                            ),
                            Container(
                              child: const Tab(
                                text: "Add Journey Plan",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .9,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * .94,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: const Color(0xfff5e1d5),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                    child: TextFormField(
                                      controller: _searchController,
                                      onTap: () {
                                        setState(() {
                                          searchStarted = true;
                                        });
                                      },
                                      onChanged: (value) {
                                        _filterMerch(value);
                                        setState(() {
                                          i = 1;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search by Merchandiser Name',
                                        hintStyle: TextStyle(
                                            color: const Color(0XFFE84201)
                                                .withOpacity(.5),
                                            fontWeight: FontWeight.w400),
                                        border: InputBorder.none,
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Color(0XFFE84201),
                                          size: 30,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _searchController.clear();
                                              FocusScope.of(context).unfocus();
                                              i = 0;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            color: Color(0XFFE84201),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .8,
                                  child: SingleChildScrollView(
                                    child: searchStarted
                                        ? _searchController.text.isEmpty
                                            ? Column(
                                                children: [
                                                  ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: lengthlist,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            print(
                                                                "Emp Id Passed : ${_data!.data![index].employeeId.toString()}");
                                                            print(
                                                                "Employee Name is : ${_data!.data![index].firstName}");
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => JourneyDetails(
                                                                      _data!
                                                                          .data![
                                                                              index]
                                                                          .employeeId
                                                                          .toString(),
                                                                      _data!
                                                                          .data![
                                                                              index]
                                                                          .firstName
                                                                          .toString())),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 6.0),
                                                            child: Card(
                                                              elevation: 0,
                                                              color:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0), //<-- SEE HERE
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _data!.data![index].surname ==
                                                                            null
                                                                        ? Text(
                                                                            "Merchandiser : ${_data!.data![index].firstName}",
                                                                            style: const TextStyle(
                                                                                color: Color(0XFFE84201),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 15),
                                                                          )
                                                                        : Text(
                                                                            "Merchandiser : ${_data!.data![index].firstName} ${_data!.data![index].surname}",
                                                                            style: const TextStyle(
                                                                                color: Color(0XFFE84201),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 16),
                                                                          ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Text(
                                                                      "Emp ID : ${_data!.data![index].employeeId}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  const SizedBox(
                                                    height: 120,
                                                  ),
                                                ],
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: filteredList1
                                                            .length,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  "Emp Id Passed : ${filteredList1[index]['emp_id']}");
                                                              print(
                                                                  "Employee Name is : ${filteredList1[index]['emp_name']}");
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => JourneyDetails(
                                                                        filteredList1[index]['emp_id']
                                                                            .toString(),
                                                                        filteredList1[index]['emp_name']
                                                                            .toString())),
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      _data!.data![index].surname ==
                                                                              null
                                                                          ? Text(
                                                                              "Merchandiser : ${filteredList1[index]['emp_name']}",
                                                                              style: const TextStyle(color: Color(0XFFE84201), fontWeight: FontWeight.w400, fontSize: 15),
                                                                            )
                                                                          : Text(
                                                                              "Merchandiser : ${filteredList1[index]['emp_name']}",
                                                                              style: const TextStyle(color: Color(0XFFE84201), fontWeight: FontWeight.w400, fontSize: 16),
                                                                            ),
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      Text(
                                                                        "Emp ID : ${filteredList1[index]['emp_id']}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w300,
                                                                            fontSize: 15),
                                                                      ),
                                                                      //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                    const SizedBox(
                                                      height: 120,
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : const SizedBox(),
                                  ),
                                )
                                // : SizedBox(
                                //     height:
                                //         MediaQuery.of(context).size.height *
                                //             .8,
                                // child: SingleChildScrollView(
                                //   child: Column(
                                //     children: [
                                //       ListView.builder(
                                //           physics:
                                //               const NeverScrollableScrollPhysics(),
                                //           itemCount:
                                //               filteredList1.length,
                                //           shrinkWrap: true,
                                //           itemBuilder:
                                //               (BuildContext context,
                                //                   int index) {
                                //             return GestureDetector(
                                //               onTap: () {
                                //                 print(
                                //                     "Emp Id Passed : ${filteredList1[index]['emp_id']}");
                                //                 print(
                                //                     "Employee Name is : ${filteredList1[index]['emp_name']}");
                                //                 Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) => JourneyDetails(
                                //                           filteredList1[
                                //                                       index]
                                //                                   [
                                //                                   'emp_id']
                                //                               .toString(),
                                //                           filteredList1[
                                //                                       index]
                                //                                   [
                                //                                   'emp_name']
                                //                               .toString())),
                                //                 );
                                //               },
                                //               child: Padding(
                                //                 padding:
                                //                     const EdgeInsets
                                //                         .only(top: 6.0),
                                //                 child: Card(
                                //                   elevation: 0,
                                //                   color: Colors.white,
                                //                   shape:
                                //                       RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius
                                //                             .circular(
                                //                                 8.0), //<-- SEE HERE
                                //                   ),
                                //                   child: Padding(
                                //                     padding:
                                //                         const EdgeInsets
                                //                             .all(8.0),
                                //                     child: Column(
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .start,
                                //                       children: [
                                //                         _data!.data![index]
                                //                                     .surname ==
                                //                                 null
                                //                             ? Text(
                                //                                 "Merchandiser : ${filteredList1[index]['emp_name']}",
                                //                                 style: const TextStyle(
                                //                                     color:
                                //                                         Color(0XFFE84201),
                                //                                     fontWeight: FontWeight.w400,
                                //                                     fontSize: 15),
                                //                               )
                                //                             : Text(
                                //                                 "Merchandiser : ${filteredList1[index]['emp_name']}",
                                //                                 style: const TextStyle(
                                //                                     color:
                                //                                         Color(0XFFE84201),
                                //                                     fontWeight: FontWeight.w400,
                                //                                     fontSize: 16),
                                //                               ),
                                //                         const SizedBox(
                                //                           height: 2,
                                //                         ),
                                //                         Text(
                                //                           "Emp ID : ${filteredList1[index]['emp_id']}",
                                //                           style: const TextStyle(
                                //                               color: Colors
                                //                                   .black,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w300,
                                //                               fontSize:
                                //                                   15),
                                //                         ),
                                //                         //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             );
                                //           }),
                                //       const SizedBox(
                                //         height: 120,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .9,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .70,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: Card(
                                    elevation: 0,
                                    color: const Color(0xfff5e1d5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), //<-- SEE HERE
                                    ),
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            i = 0;
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 40,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: const Border(
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          .0001)),
                                                              borderRadius: const BorderRadius
                                                                  .horizontal(
                                                                  right: Radius
                                                                      .circular(
                                                                          0),
                                                                  left: Radius
                                                                      .circular(
                                                                          20)),
                                                              color: i == 0
                                                                  ? const Color(
                                                                      0XFFE84201)
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Scheduled",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: i == 0
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ))),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            i = 1;
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: const Border(
                                                                bottom: BorderSide(
                                                                    width:
                                                                        .0001)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .horizontal(
                                                                    left: Radius
                                                                        .circular(
                                                                            0),
                                                                    right: Radius
                                                                        .circular(
                                                                            20)),
                                                            color: i == 1
                                                                ? const Color(
                                                                    0XFFE84201)
                                                                : Colors.white,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Unscheduled",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: i == 1
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .90,
                                                  ),
                                                ],
                                              ),
                                              i == 0
                                                  ? Positioned(
                                                      top: 60,
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 10,
                                                      child: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs1 =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      merch = prefs1
                                                                          .get(
                                                                              "merch")
                                                                          .toString();
                                                                      //  merch1 = prefs1.get("merch1").toString();
                                                                      empName = prefs1
                                                                          .get(
                                                                              "empName")
                                                                          .toString();
                                                                      //  empName1 = prefs1.get("empName1").toString();
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .85,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            physics:
                                                                                const NeverScrollableScrollPhysics(),
                                                                            child:
                                                                                SelectMerchandiser("0"),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(() {
                                                                    merch = prefs1
                                                                        .get(
                                                                            "merch")
                                                                        .toString();
                                                                    empName = prefs1
                                                                        .get(
                                                                            "empName")
                                                                        .toString();
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: 50,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            merch == "" || merch == "null"
                                                                                ? "Select Merchandiser"
                                                                                : empName,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.arrow_drop_down_sharp,
                                                                              size: 30,
                                                                            ),
                                                                            // IconButton(onPressed: () {
                                                                            //   setState(() {
                                                                            //     merch = "";
                                                                            //   });
                                                                            // }, icon: Icon(
                                                                            //   Icons
                                                                            //       .clear,
                                                                            //   size:
                                                                            //       20,
                                                                            //   color: Colors
                                                                            //       .black
                                                                            //       .withOpacity(.5),
                                                                            // ),),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                SharedPreferences prefs1 = await SharedPreferences.getInstance();
                                                                                setState(() {
                                                                                  merch = "";
                                                                                  empName = "";
                                                                                  prefs1.setString('merch', "");
                                                                                  prefs1.setString("empName", "");
                                                                                });
                                                                              },
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 20,
                                                                                color: Colors.black.withOpacity(.5),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs1 =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        // height: MediaQuery.of(context)
                                                                        //         .size
                                                                        //         .height *
                                                                        //     .85,
                                                                        height:
                                                                            50,

                                                                        width: MediaQuery.of(context).size.width *
                                                                            .7,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              SelectOutlets("0"),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(() {
                                                                    out = prefs1
                                                                        .get(
                                                                            "out")
                                                                        .toString();
                                                                    stores = prefs1
                                                                        .get(
                                                                            "store")
                                                                        .toString();
                                                                    l = out
                                                                        .length;
                                                                    out1 = out
                                                                        .substring(
                                                                            1,
                                                                            (l -
                                                                                1))
                                                                        .split(
                                                                            ',');
                                                                    let = out1
                                                                        .map(int
                                                                            .parse)
                                                                        .toList();
                                                                    Preference
                                                                        .setOutlets(
                                                                            []);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: l <= 2
                                                                      ? 50
                                                                      : double.parse(
                                                                          "${10 * l}"),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            out == ""
                                                                                ? "Select Outlets"
                                                                                : formatStoreNames(stores),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.arrow_drop_down_sharp,
                                                                              size: 30,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  out = "";
                                                                                  l = 5;
                                                                                });
                                                                              },
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 20,
                                                                                color: Colors.black.withOpacity(.5),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .65,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .7,
                                                                        child:
                                                                            StatefulBuilder(
                                                                          builder:
                                                                              (context, setState) {
                                                                            return Dialog(
                                                                              child: Column(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemCount: _months.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return CheckboxListTile(
                                                                                          title: Text(_months[index]),
                                                                                          value: _isMonthChecked[index],
                                                                                          onChanged: (val) {
                                                                                            setState(() {
                                                                                              _isMonthChecked[index] = val!;
                                                                                              if (val) {
                                                                                                month.add(_months[index]);
                                                                                                _months[index] == "January"
                                                                                                    ? intMonth.add(1)
                                                                                                    : _months[index] == "February"
                                                                                                        ? intMonth.add(2)
                                                                                                        : _months[index] == "March"
                                                                                                            ? intMonth.add(3)
                                                                                                            : _months[index] == "April"
                                                                                                                ? intMonth.add(4)
                                                                                                                : _months[index] == "May"
                                                                                                                    ? intMonth.add(5)
                                                                                                                    : _months[index] == "June"
                                                                                                                        ? intMonth.add(6)
                                                                                                                        : _months[index] == "July"
                                                                                                                            ? intMonth.add(7)
                                                                                                                            : _months[index] == "August"
                                                                                                                                ? intMonth.add(8)
                                                                                                                                : _months[index] == "September"
                                                                                                                                    ? intMonth.add(9)
                                                                                                                                    : _months[index] == "October"
                                                                                                                                        ? intMonth.add(10)
                                                                                                                                        : _months[index] == "November"
                                                                                                                                            ? intMonth.add(11)
                                                                                                                                            : intMonth.add(12);
                                                                                                print("Int Values of Selected Months : $intMonth");
                                                                                              } else {
                                                                                                month.remove(_months[index]);
                                                                                                _months[index] == "January"
                                                                                                    ? intMonth.remove(1)
                                                                                                    : _months[index] == "February"
                                                                                                        ? intMonth.remove(2)
                                                                                                        : _months[index] == "March"
                                                                                                            ? intMonth.remove(3)
                                                                                                            : _months[index] == "April"
                                                                                                                ? intMonth.remove(4)
                                                                                                                : _months[index] == "May"
                                                                                                                    ? intMonth.remove(5)
                                                                                                                    : _months[index] == "June"
                                                                                                                        ? intMonth.remove(6)
                                                                                                                        : _months[index] == "July"
                                                                                                                            ? intMonth.remove(7)
                                                                                                                            : _months[index] == "August"
                                                                                                                                ? intMonth.remove(8)
                                                                                                                                : _months[index] == "September"
                                                                                                                                    ? intMonth.remove(9)
                                                                                                                                    : _months[index] == "October"
                                                                                                                                        ? intMonth.remove(10)
                                                                                                                                        : _months[index] == "November"
                                                                                                                                            ? intMonth.remove(11)
                                                                                                                                            : intMonth.remove(12);
                                                                                              }
                                                                                              print("Selected Months: $month");
                                                                                              selectedMonths = month.toString();
                                                                                              print("Selected int values of months : $intMonth");
                                                                                            });
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        selectedMonths = month.toString();
                                                                                      });
                                                                                      Navigator.pop(context, true);
                                                                                    },
                                                                                    child: const Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text("Save"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: month
                                                                              .length <=
                                                                          1
                                                                      ? 50
                                                                      : (month.length *
                                                                          30),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 20),
                                                                          month.isNotEmpty
                                                                              ? Text(
                                                                                  formatMonths(selectedMonths),
                                                                                  style: TextStyle(
                                                                                    color: Colors.black.withOpacity(.5),
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  "Select Month",
                                                                                  style: TextStyle(
                                                                                    color: Colors.black.withOpacity(.5),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.arrow_drop_down_sharp,
                                                                              size: 30,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  month.clear();
                                                                                  intMonth.clear();
                                                                                  selectedMonths = "";
                                                                                  _isMonthChecked = [
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                  ];
                                                                                });
                                                                              },
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 20,
                                                                                color: Colors.black.withOpacity(.5),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              // GestureDetector(
                                                              //   onTap: () {
                                                              //     showDialog<
                                                              //         void>(
                                                              //       context:
                                                              //           context,
                                                              //       barrierDismissible:
                                                              //           true, // user must tap button!
                                                              //       builder:
                                                              //           (BuildContext
                                                              //               context) {
                                                              //         return SizedBox(
                                                              //           height: MediaQuery.of(context).size.height *
                                                              //               .65,
                                                              //           width: MediaQuery.of(context).size.width *
                                                              //               .7,
                                                              //           child: Dialog(
                                                              //               child: Padding(
                                                              //             padding: const EdgeInsets
                                                              //                 .all(
                                                              //                 15.0),
                                                              //             child:
                                                              //                 Column(
                                                              //               crossAxisAlignment:
                                                              //                   CrossAxisAlignment.start,
                                                              //               children: [
                                                              //                 const SizedBox(
                                                              //                   height: 15,
                                                              //                 ),
                                                              //                 const Text(
                                                              //                   "Select Month",
                                                              //                   style: TextStyle(fontSize: 16),
                                                              //                 ),
                                                              //                 const SizedBox(
                                                              //                   height: 15,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "1";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "January",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "2";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "February",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "3";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "March",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "4";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "April",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "5";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "May",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "6";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "June",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "7";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "July",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "8";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "August",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "9";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "September",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "10";
                                                              //                         Navigator.pop(context);
                                                              //                       });
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "October",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "11";
                                                              //                       });
                                                              //                       Navigator.pop(context);
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "November",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //                 const SizedBox(
                                                              //                   height: 13,
                                                              //                 ),
                                                              //                 GestureDetector(
                                                              //                     onTap: () {
                                                              //                       setState(() {
                                                              //                         month = "12";
                                                              //                       });
                                                              //                       Navigator.pop(context);
                                                              //                     },
                                                              //                     child: const Text(
                                                              //                       "December",
                                                              //                       style: TextStyle(fontSize: 16),
                                                              //                     )),
                                                              //               ],
                                                              //             ),
                                                              //           )),
                                                              //         );
                                                              //       },
                                                              //     );
                                                              //   },
                                                              //   child:
                                                              //       Container(
                                                              //     width: MediaQuery.of(
                                                              //                 context)
                                                              //             .size
                                                              //             .width *
                                                              //         .95,
                                                              //     height: 50,
                                                              //     decoration:
                                                              //         const BoxDecoration(
                                                              //       border: Border(
                                                              //           bottom: BorderSide(
                                                              //               width:
                                                              //                   .0001)),
                                                              //       borderRadius:
                                                              //           BorderRadius.all(
                                                              //               Radius.circular(10)),
                                                              //       color: Colors
                                                              //           .white,
                                                              //     ),
                                                              //     child: Row(
                                                              //       mainAxisAlignment:
                                                              //           MainAxisAlignment
                                                              //               .spaceBetween,
                                                              //       children: [
                                                              //         Row(
                                                              //           children: [
                                                              //             const SizedBox(
                                                              //               width:
                                                              //                   20,
                                                              //             ),
                                                              //             Text(
                                                              //               month == "1"
                                                              //                   ? "January"
                                                              //                   : month == "2"
                                                              //                       ? "February"
                                                              //                       : month == "3"
                                                              //                           ? "March"
                                                              //                           : month == "4"
                                                              //                               ? "April"
                                                              //                               : month == "5"
                                                              //                                   ? "May"
                                                              //                                   : month == "6"
                                                              //                                       ? "June"
                                                              //                                       : month == "7"
                                                              //                                           ? "July"
                                                              //                                           : month == "8"
                                                              //                                               ? "August"
                                                              //                                               : month == "9"
                                                              //                                                   ? "September"
                                                              //                                                   : month == "10"
                                                              //                                                       ? "October"
                                                              //                                                       : month == "11"
                                                              //                                                           ? "November"
                                                              //                                                           : month == "12"
                                                              //                                                               ? "December"
                                                              //                                                               : "Select Month",
                                                              //               style:
                                                              //                   TextStyle(
                                                              //                 color: Colors.black.withOpacity(.5),
                                                              //               ),
                                                              //             ),
                                                              //           ],
                                                              //         ),
                                                              //         SizedBox(
                                                              //           width:
                                                              //               60,
                                                              //           child:
                                                              //               Row(
                                                              //             mainAxisAlignment:
                                                              //                 MainAxisAlignment.end,
                                                              //             children: [
                                                              //               const Icon(
                                                              //                 Icons.arrow_drop_down_sharp,
                                                              //                 size: 30,
                                                              //               ),
                                                              //               GestureDetector(
                                                              //                 onTap: () {
                                                              //                   setState(() {
                                                              //                     month = "";
                                                              //                   });
                                                              //                 },
                                                              //                 child: Icon(
                                                              //                   Icons.clear,
                                                              //                   size: 20,
                                                              //                   color: Colors.black.withOpacity(.5),
                                                              //                 ),
                                                              //               ),
                                                              //               const SizedBox(
                                                              //                 width: 10,
                                                              //               ),
                                                              //             ],
                                                              //           ),
                                                              //         ),
                                                              //       ],
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .65,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .7,
                                                                        child:
                                                                            StatefulBuilder(
                                                                          builder:
                                                                              (context, setState) {
                                                                            return Dialog(
                                                                              child: Column(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemCount: _texts.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return CheckboxListTile(
                                                                                          title: Text(_texts[index]),
                                                                                          value: _isChecked[index],
                                                                                          onChanged: (val) {
                                                                                            setState(() {
                                                                                              _isChecked[index] = val!;
                                                                                              if (val) {
                                                                                                day.add(_texts[index]);
                                                                                              } else {
                                                                                                day.remove(_texts[index]);
                                                                                              }
                                                                                              print("Selected Days: $day");
                                                                                              selectedDays = day.toString();
                                                                                            });
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        selectedDays = day.toString();
                                                                                      });
                                                                                      Navigator.pop(context, true);
                                                                                    },
                                                                                    child: const Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text("Save"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: day.length <=
                                                                          1
                                                                      ? 50
                                                                      : (day.length *
                                                                          30),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 20),
                                                                          day.isNotEmpty
                                                                              ? Text(
                                                                                  formatDayss(selectedDays),
                                                                                  style: TextStyle(
                                                                                    color: Colors.black.withOpacity(.5),
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  "Select Days",
                                                                                  style: TextStyle(
                                                                                    color: Colors.black.withOpacity(.5),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.arrow_drop_down_sharp,
                                                                              size: 30,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  day.clear();
                                                                                  selectedDays = "";
                                                                                  _isChecked = [
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false,
                                                                                    false
                                                                                  ];
                                                                                });
                                                                              },
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 20,
                                                                                color: Colors.black.withOpacity(.5),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          prefs1 =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      // var response = ApiServices.service.addschedule(
                                                                      //     context,
                                                                      //     merch,
                                                                      //     month,
                                                                      //     day,
                                                                      //     "2024",
                                                                      //     let);
                                                                      var response = ApiServices.service.addschedule(
                                                                          context,
                                                                          merch,
                                                                          intMonth,
                                                                          day,
                                                                          thisYear,
                                                                          let);
                                                                      response.then(
                                                                          (value) =>
                                                                              {
                                                                                Navigator.pop(context)
                                                                              });
                                                                      print(
                                                                          "The passed values : $merch, $intMonth, $day, $let, $thisYear");
                                                                      prefs1.setString(
                                                                          'merch',
                                                                          "");
                                                                      prefs1.setString(
                                                                          "empName",
                                                                          "");
                                                                    },
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .19,
                                                                      height:
                                                                          40,
                                                                      child: Card(
                                                                          elevation: 0,
                                                                          color: const Color(0XFFE84201),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0), //<-- SEE HERE
                                                                          ),
                                                                          child: const Center(
                                                                              child: Text(
                                                                            "SAVE",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      top: 60,
                                                      left: 10,
                                                      right: 10,
                                                      child: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs1 =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .85,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                SelectMerchandiser("2"),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(() {
                                                                    merch1 = prefs1
                                                                        .get(
                                                                            "merch1")
                                                                        .toString();
                                                                    empName1 = prefs1
                                                                        .get(
                                                                            "empName1")
                                                                        .toString();
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: 60,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            merch1 == "" || merch1 == "null"
                                                                                ? "Select Merchandiser"
                                                                                : empName1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.arrow_drop_down_sharp,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              SharedPreferences prefs1 = await SharedPreferences.getInstance();
                                                                              setState(() {
                                                                                merch1 = "";
                                                                                empName1 = "";
                                                                                prefs1.setString('merch1', "");
                                                                                prefs1.setString("empName1", "");
                                                                              });
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: 20,
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs1 =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .85,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .7,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              SelectOutlets("2"),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  setState(() {
                                                                    out2 = prefs1
                                                                        .get(
                                                                            "out1")
                                                                        .toString();
                                                                    stores1 = prefs1
                                                                        .get(
                                                                            "store1")
                                                                        .toString();
                                                                    m = out2
                                                                        .length;
                                                                    out3 = out2
                                                                        .substring(
                                                                            1,
                                                                            (m -
                                                                                1))
                                                                        .split(
                                                                            ',');
                                                                    let1 = out3
                                                                        .map(int
                                                                            .parse)
                                                                        .toList();
                                                                    Preference
                                                                        .setOutlets1(
                                                                            []);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: m <= 2
                                                                      ? 50
                                                                      : double.parse(
                                                                          "${10 * m}"),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            out2 == ""
                                                                                ? "Select Outlets"
                                                                                : formatStoreNames(stores1),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.arrow_drop_down_sharp,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                out2 = "";
                                                                                m = 5;
                                                                              });
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: 20,
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return SizedBox(
                                                                        height:
                                                                            340,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .7,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.white,
                                                                            height:
                                                                                340,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                SfDateRangePicker(
                                                                                  view: DateRangePickerView.month,
                                                                                  allowViewNavigation: false,
                                                                                  onSelectionChanged: _onSelectionChanged,
                                                                                  selectionMode: DateRangePickerSelectionMode.single,
                                                                                  backgroundColor: Colors.black12,
                                                                                  headerHeight: 60,
                                                                                  selectionColor: const Color(0XFFE84201),
                                                                                  headerStyle: const DateRangePickerHeaderStyle(
                                                                                    textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
                                                                                    textAlign: TextAlign.center,
                                                                                    backgroundColor: Color(0XFFE84201),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.all(8.0),
                                                                                        child: Text("Ok    "),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .95,
                                                                  height: 60,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                .0001)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            "Select Date",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            _selectedDate == ""
                                                                                ? ""
                                                                                : _selectedDate.substring(0, 10).toString(),
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontSize: 13),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          const Icon(
                                                                            Icons.calendar_month,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      var response = ApiServices.service.addunschedule(
                                                                          context,
                                                                          merch1,
                                                                          _selectedDate
                                                                              .substring(0, 10)
                                                                              .toString(),
                                                                          let1);
                                                                      response.then(
                                                                          (value) =>
                                                                              {
                                                                                Navigator.pop(context)
                                                                              });
                                                                    },
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .19,
                                                                      height:
                                                                          50,
                                                                      child: Card(
                                                                          elevation: 0,
                                                                          color: const Color(0XFFE84201),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0), //<-- SEE HERE
                                                                          ),
                                                                          child: const Center(
                                                                              child: Text(
                                                                            "SAVE",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * .25,
            child: FloatingActionButton(
              backgroundColor: const Color(0xfff5e1d5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWeekPage()),
                );
              },
              child: const Text(
                "Week Off",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0XFFE84201),
                ),
              ),
            ),
          ),
        ));
  }
}
