// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:rms/Employee/Preference.dart';
// import 'package:rms/FieldManager/AddWeekPage.dart';
// import 'package:rms/FieldManager/ApiService.dart';
// import 'package:rms/FieldManager/JourneyDetails.dart';
// import 'package:rms/FieldManager/SelectOutlets.dart';
// import 'package:rms/FieldManager/Selectmerchandiser.dart';
// import 'package:rms/NetworkModelfm/Merchandiser_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// import '../Employee/version.dart';

// class JourneyManager extends StatefulWidget {
//   Data? data;
//   String j = "";
//   JourneyManager(this.j, {super.key});
//   @override
//   State<JourneyManager> createState() => _JourneyManagerState(data, j);
// }

// class _JourneyManagerState extends State<JourneyManager> {
//   int i = 0;
//   int l = 0;
//   int m = 0;
//   String j = "";
//   String merch = "";
//   String merch1 = "";
//   String empName = "";
//   String empName1 = "";
//   String out = "Select Outlets";
//   String out2 = "Select Outlets";
//   String stores = "Select Outlets";
//   String stores1 = "Select Outlets";
//   String userName = "";
//   String emp = "";
//   List<int> let = [];
//   List<int> let1 = [];
//   List<String> out1 = [];
//   List<String> out3 = [];
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   var date = DateTime.timestamp();
//   MerchandiserModel? _data;
//   _JourneyManagerState(Data? data, this.j);
//   String _selectedDate = '';
//   var day = [];
//   String _dateCount = '';
//   String _range = '';
//   String _rangeCount = '';
//   var month = [];
//   String selectedMonths = '';
//   late String selectedDays;
//   bool saveClicked = false;
//   bool month1 = false;
//   bool month2 = false;
//   bool month3 = false;
//   bool month4 = false;
//   bool month5 = false;
//   bool month6 = false;
//   bool month7 = false;
//   bool month8 = false;
//   bool month9 = false;
//   bool month10 = false;
//   bool month11 = false;
//   bool month12 = false;
//   List<bool> _isChecked = [false, false, false, false, false, false, false];
//   List<bool> _isMonthChecked = [false, false, false, false, false, false, false, false, false, false, false, false,];
//   final List<String> _texts = [
//     "Monday",
//     "Tuesday",
//     "Wednesday",
//     "Thursday",
//     "Friday",
//     "Saturday",
//     "Sunday",
//   ];

//   final List<String> _months = [
//     "January",
//     "Februay",
//     "March",
//     "April",
//     "May",
//     "June",
//     "July",
//     "August",
//     "September",
//     "October",
//     "November",
//     "December",
//   ];

//   _gettodayplanned() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     userName = prefs1.get("user").toString();
//     emp = prefs1.get("id").toString();
//     await ApiServices.service
//         .merchandiser(
//           context,
//         )
//         .then((value) => {
//               setState(() {
//                 _data = value;
//                 myList.addAll(_data!.data!);
//                 lengthlist = myList.length;
//               })
//             });
//   }

//   String formatStoreNames(String storeNames) {
//     // Split the string by commas and join with newline characters
//     return storeNames.split(', ').join('\n');
//   }

//   String formatDayss(String days) {
//     // Split the string by commas and join with newline characters
//     return days.split(', ').join('\n');
//   }

//    String formatMonths(String months) {
//     // Split the string by commas and join with newline characters
//     return months.split(', ').join('\n');
//   }

//   _refresh() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     setState(() {
//       j == "1" ? i = 0 : i = 1;
//       merch = prefs1.get("merch").toString();
//       merch1 = prefs1.get("merch1").toString();
//       print("Value of merch : $merch");
//       empName = prefs1.get("empName").toString();
//       empName1 = prefs1.get("empName1").toString();
//       print("The Merchandiser Name Fetched from Shared Preferences : $empName");
//       out = prefs1.get("out").toString() == ""
//           ? out
//           : prefs1.get("out").toString();
//       out == "Select Outlets" ? "Select Outlets" : l = out.length;
//       l == 0 ? l = 0 : out1 = out.substring(1, (l - 1)).split(',');
//       out1 == [] ? "" : let = out1.map(int.parse).toList();
//       Preference.setOutlets([]);
//       stores = prefs1.get("store").toString();
//       print("The selected stores : $stores");
//     });
//   }

//   _refresh1() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     setState(() {
//       j == "1" ? i = 0 : i = 1;
//       out2 = prefs1.get("out1").toString() == ""
//           ? out2
//           : prefs1.get("out1").toString();
//       out2 == "Select Outlets" ? "Select Outlets" : m = out2.length;
//       m == 0 ? m = 0 : out3 = out2.substring(1, (m - 1)).split(',');
//       out3 == [] ? "" : let1 = out3.map(int.parse).toList();
//       Preference.setOutlets1([]);
//       stores1 = prefs1.get("store1").toString();
//       print("The selected stores : $stores1");
//     });
//   }

//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//             // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }

//   @override
//   initState() {
//     super.initState();
//     _gettodayplanned();
//     _refresh();
//     _refresh1();
//     _isChecked = List<bool>.filled(_texts.length, false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         initialIndex: 1,
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 3,
//             backgroundColor: const Color(0xfff5e1d5),
//             foregroundColor: const Color(0XFFE84201),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text("Journey Plans"),
//                 userName.isNotEmpty
//                     ? Text(
//                         "$userName($emp) - v ${AppVersion.version}",
//                         style:
//                             const TextStyle(fontSize: 9, color: Colors.black),
//                       )
//                     : const Text(""),
//               ],
//             ),
//           ),
//           body: SingleChildScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("images/Pattern.png"),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Container(
//                         color: Colors.white,
//                         height: 35,
//                         width: MediaQuery.of(context).size.width,
//                         child: TabBar(
//                           indicatorColor: const Color(0XFFE84201),
//                           labelColor: const Color(0XFFE84201),
//                           labelStyle: TextStyle(
//                               color: Colors.black.withOpacity(.6),
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14),
//                           indicatorSize: TabBarIndicatorSize.tab,
//                           tabAlignment: TabAlignment.fill,
//                           isScrollable: false,
//                           tabs: [
//                             const Tab(
//                               text: "Journey Plan Details",
//                             ),
//                             Container(
//                               child: const Tab(
//                                 text: "Add Journey Plan",
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .9,
//                       width: MediaQuery.of(context).size.width,
//                       child: TabBarView(
//                         children: [
//                           Container(
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   height: 60,
//                                   width:
//                                       MediaQuery.of(context).size.width * .94,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50.0),
//                                     color: const Color(0xfff5e1d5),
//                                   ),
//                                   padding: const EdgeInsets.all(8),
//                                   child: Center(
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintText: 'Search by Outlet Name',
//                                         hintStyle: TextStyle(
//                                             color: const Color(0XFFE84201)
//                                                 .withOpacity(.5),
//                                             fontWeight: FontWeight.w400),
//                                         border: InputBorder.none,
//                                         prefixIcon: const Icon(
//                                           Icons.search,
//                                           color: Color(0XFFE84201),
//                                           size: 30,
//                                         ),
//                                         suffixIcon: const Icon(
//                                           Icons.clear,
//                                           color: Color(0XFFE84201),
//                                           size: 25,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * .8,
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       children: [
//                                         ListView.builder(
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             itemCount: lengthlist,
//                                             shrinkWrap: true,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   print(
//                                                       "Emp Id Passed : ${_data!.data![index].employeeId.toString()}");
//                                                   print(
//                                                       "Employee Name is : ${_data!.data![index].firstName}");
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             JourneyDetails(
//                                                                 _data!
//                                                                     .data![
//                                                                         index]
//                                                                     .employeeId
//                                                                     .toString(),
//                                                                 _data!
//                                                                     .data![
//                                                                         index]
//                                                                     .firstName
//                                                                     .toString())),
//                                                   );
//                                                 },
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 6.0),
//                                                   child: Card(
//                                                     elevation: 0,
//                                                     color: Colors.white,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8.0), //<-- SEE HERE
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           _data!.data![index]
//                                                                       .surname ==
//                                                                   null
//                                                               ? Text(
//                                                                   "Merchandiser : ${_data!.data![index].firstName}",
//                                                                   style: const TextStyle(
//                                                                       color: Color(
//                                                                           0XFFE84201),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400,
//                                                                       fontSize:
//                                                                           15),
//                                                                 )
//                                                               : Text(
//                                                                   "Merchandiser : ${_data!.data![index].firstName} ${_data!.data![index].surname}",
//                                                                   style: const TextStyle(
//                                                                       color: Color(
//                                                                           0XFFE84201),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400,
//                                                                       fontSize:
//                                                                           16),
//                                                                 ),
//                                                           const SizedBox(
//                                                             height: 2,
//                                                           ),
//                                                           Text(
//                                                             "Emp ID : ${_data!.data![index].employeeId}",
//                                                             style: const TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w300,
//                                                                 fontSize: 15),
//                                                           ),
//                                                           //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }),
//                                         const SizedBox(
//                                           height: 120,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .9,
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * .70,
//                                   width: MediaQuery.of(context).size.width * .9,
//                                   child: Card(
//                                     elevation: 0,
//                                     color: const Color(0xfff5e1d5),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           8.0), //<-- SEE HERE
//                                     ),
//                                     child: SingleChildScrollView(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       child: Column(
//                                         children: [
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Stack(
//                                             clipBehavior: Clip.none,
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             i = 0;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                             height: 40,
//                                                             width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width *
//                                                                 .3,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               border: const Border(
//                                                                   bottom: BorderSide(
//                                                                       width:
//                                                                           .0001)),
//                                                               borderRadius: const BorderRadius
//                                                                   .horizontal(
//                                                                   right: Radius
//                                                                       .circular(
//                                                                           0),
//                                                                   left: Radius
//                                                                       .circular(
//                                                                           20)),
//                                                               color: i == 0
//                                                                   ? const Color(
//                                                                       0XFFE84201)
//                                                                   : Colors
//                                                                       .white,
//                                                             ),
//                                                             child: Center(
//                                                                 child: Text(
//                                                               "Scheduled",
//                                                               style: TextStyle(
//                                                                   fontSize: 13,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: i == 0
//                                                                       ? Colors
//                                                                           .white
//                                                                       : Colors
//                                                                           .black),
//                                                             ))),
//                                                       ),
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             i = 1;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           height: 40,
//                                                           width: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .width *
//                                                               .3,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             border: const Border(
//                                                                 bottom: BorderSide(
//                                                                     width:
//                                                                         .0001)),
//                                                             borderRadius:
//                                                                 const BorderRadius
//                                                                     .horizontal(
//                                                                     left: Radius
//                                                                         .circular(
//                                                                             0),
//                                                                     right: Radius
//                                                                         .circular(
//                                                                             20)),
//                                                             color: i == 1
//                                                                 ? const Color(
//                                                                     0XFFE84201)
//                                                                 : Colors.white,
//                                                           ),
//                                                           child: Center(
//                                                             child: Text(
//                                                               "Unscheduled",
//                                                               style: TextStyle(
//                                                                   fontSize: 13,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: i == 1
//                                                                       ? Colors
//                                                                           .white
//                                                                       : Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Container(
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .90,
//                                                   ),
//                                                 ],
//                                               ),
//                                               i == 0
//                                                   ? Positioned(
//                                                       top: 60,
//                                                       left: 10,
//                                                       right: 10,
//                                                       bottom: 10,
//                                                       child: Container(
//                                                         child:
//                                                             SingleChildScrollView(
//                                                           child: Column(
//                                                             children: [
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   SharedPreferences
//                                                                       prefs1 =
//                                                                       await SharedPreferences
//                                                                           .getInstance();
//                                                                   showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true, // user must tap button!
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       merch = prefs1
//                                                                           .get(
//                                                                               "merch")
//                                                                           .toString();
//                                                                       //  merch1 = prefs1.get("merch1").toString();
//                                                                       empName = prefs1
//                                                                           .get(
//                                                                               "empName")
//                                                                           .toString();
//                                                                       //  empName1 = prefs1.get("empName1").toString();
//                                                                       return SizedBox(
//                                                                         height: MediaQuery.of(context).size.height *
//                                                                             .85,
//                                                                         child:
//                                                                             Dialog(
//                                                                           child:
//                                                                               SingleChildScrollView(
//                                                                             physics:
//                                                                                 const NeverScrollableScrollPhysics(),
//                                                                             child:
//                                                                                 SelectMerchandiser("0"),
//                                                                           ),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(() {
//                                                                     merch = prefs1
//                                                                         .get(
//                                                                             "merch")
//                                                                         .toString();
//                                                                     empName = prefs1
//                                                                         .get(
//                                                                             "empName")
//                                                                         .toString();
//                                                                   });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: 50,
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 20,
//                                                                           ),
//                                                                           Text(
//                                                                             merch == "" || merch == "null"
//                                                                                 ? "Select Merchandiser"
//                                                                                 : empName,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             60,
//                                                                         child:
//                                                                             Row(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.end,
//                                                                           children: [
//                                                                             const Icon(
//                                                                               Icons.arrow_drop_down_sharp,
//                                                                               size: 30,
//                                                                             ),
//                                                                             // IconButton(onPressed: () {
//                                                                             //   setState(() {
//                                                                             //     merch = "";
//                                                                             //   });
//                                                                             // }, icon: Icon(
//                                                                             //   Icons
//                                                                             //       .clear,
//                                                                             //   size:
//                                                                             //       20,
//                                                                             //   color: Colors
//                                                                             //       .black
//                                                                             //       .withOpacity(.5),
//                                                                             // ),),
//                                                                             GestureDetector(
//                                                                               onTap: () async {
//                                                                                 SharedPreferences prefs1 = await SharedPreferences.getInstance();
//                                                                                 setState(() {
//                                                                                   merch = "";
//                                                                                   empName = "";
//                                                                                   prefs1.setString('merch', "");
//                                                                                   prefs1.setString("empName", "");
//                                                                                 });
//                                                                               },
//                                                                               child: Icon(
//                                                                                 Icons.clear,
//                                                                                 size: 20,
//                                                                                 color: Colors.black.withOpacity(.5),
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(
//                                                                               width: 10,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   SharedPreferences
//                                                                       prefs1 =
//                                                                       await SharedPreferences
//                                                                           .getInstance();
//                                                                   showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true, // user must tap button!
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         // height: MediaQuery.of(context)
//                                                                         //         .size
//                                                                         //         .height *
//                                                                         //     .85,
//                                                                         height:
//                                                                             50,

//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             .7,
//                                                                         child:
//                                                                             Dialog(
//                                                                           child:
//                                                                               SelectOutlets("0"),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(() {
//                                                                     out = prefs1
//                                                                         .get(
//                                                                             "out")
//                                                                         .toString();
//                                                                     stores = prefs1
//                                                                         .get(
//                                                                             "store")
//                                                                         .toString();
//                                                                     l = out
//                                                                         .length;
//                                                                     out1 = out
//                                                                         .substring(
//                                                                             1,
//                                                                             (l -
//                                                                                 1))
//                                                                         .split(
//                                                                             ',');
//                                                                     let = out1
//                                                                         .map(int
//                                                                             .parse)
//                                                                         .toList();
//                                                                     Preference
//                                                                         .setOutlets(
//                                                                             []);
//                                                                   });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: l <= 2
//                                                                       ? 50
//                                                                       : double.parse(
//                                                                           "${10 * l}"),
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 20,
//                                                                           ),
//                                                                           Text(
//                                                                             out == ""
//                                                                                 ? "Select Outlets"
//                                                                                 : formatStoreNames(stores),
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             60,
//                                                                         child:
//                                                                             Row(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.end,
//                                                                           children: [
//                                                                             const Icon(
//                                                                               Icons.arrow_drop_down_sharp,
//                                                                               size: 30,
//                                                                             ),
//                                                                             GestureDetector(
//                                                                               onTap: () {
//                                                                                 setState(() {
//                                                                                   out = "";
//                                                                                   l = 5;
//                                                                                 });
//                                                                               },
//                                                                               child: Icon(
//                                                                                 Icons.clear,
//                                                                                 size: 20,
//                                                                                 color: Colors.black.withOpacity(.5),
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(
//                                                                               width: 10,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               // const SizedBox(
//                                                               //   height: 10,
//                                                               // ),
//                                                               // GestureDetector(
//                                                               //   onTap: () {
//                                                               //     showDialog<
//                                                               //         void>(
//                                                               //       context:
//                                                               //           context,
//                                                               //       barrierDismissible:
//                                                               //           true, // user must tap button!
//                                                               //       builder:
//                                                               //           (BuildContextcontext) {
//                                                               //         return StatefulBuilder(builder:
//                                                               //             (stfContext,
//                                                               //                 setState) {
//                                                               //           return SizedBox(
//                                                               //             height:
//                                                               //                 MediaQuery.of(context).size.height * .65,
//                                                               //             width:
//                                                               //                 MediaQuery.of(context).size.width * .7,
//                                                               //             child: Dialog(
//                                                               //                 child: Padding(
//                                                               //               padding:
//                                                               //                   const EdgeInsets.all(15.0),
//                                                               //               child:
//                                                               //                   Column(
//                                                               //                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                               //                 children: [
//                                                               //                   const SizedBox(
//                                                               //                     height: 15,
//                                                               //                   ),
//                                                               //                   const Text(
//                                                               //                     "Select Month",
//                                                               //                     style: TextStyle(fontSize: 16),
//                                                               //                   ),
//                                                               //                   const SizedBox(
//                                                               //                     height: 10,
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month1,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month1 = value!;
//                                                               //                             value == true ? month.add("January") : month.remove("January");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "January",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month2,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month2 = value!;
//                                                               //                             value == true ? month.add("February") : month.remove("February");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "February",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month3,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month3 = value!;
//                                                               //                             value == true ? month.add("March") : month.remove("March");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "March",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month4,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month4 = value!;
//                                                               //                             value == true ? month.add("April") : month.remove("April");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "April",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month5,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month5 = value!;
//                                                               //                             value == true ? month.add("May") : month.remove("May");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "May",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month6,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month6 = value!;
//                                                               //                             value == true ? month.add("June") : month.remove("June");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "June",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month7,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month7 = value!;
//                                                               //                             value == true ? month.add("July") : month.remove("July");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "July",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month8,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month8 = value!;
//                                                               //                             value == true ? month.add("August") : month.remove("August");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "August",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month9,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month9 = value!;
//                                                               //                             value == true ? month.add("September") : month.remove("September");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "September",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month10,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month10 = value!;
//                                                               //                             value == true ? month.add("October") : month.remove("October");
//                                                               //                             //month.add("October");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "October",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month11,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month11 = value!;
//                                                               //                             value == true ? month.add("November") : month.remove("November");
//                                                               //                             //month.add("November");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "November",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   Row(
//                                                               //                     children: [
//                                                               //                       Checkbox(
//                                                               //                         value: month12,
//                                                               //                         onChanged: (bool? value) {
//                                                               //                           setState(() {
//                                                               //                             month12 = value!;
//                                                               //                             value == true ? month.add("December") : month.remove("December");
//                                                               //                             //month.add("December");
//                                                               //                           });
//                                                               //                         },
//                                                               //                       ),
//                                                               //                       const Text(
//                                                               //                         "December",
//                                                               //                         style: TextStyle(fontSize: 16),
//                                                               //                       ),
//                                                               //                     ],
//                                                               //                   ),
//                                                               //                   GestureDetector(
//                                                               //                     onTap: () {
//                                                               //                       print(month);
//                                                               //                       setState(() {
//                                                               //                         selectedMonths = month.toString();
//                                                               //                       });
//                                                               //                       print("Selected Months : $selectedMonths");
//                                                               //                       Navigator.pop(context);
//                                                               //                       setState(() {});
//                                                               //                     },
//                                                               //                     child: const Card(
//                                                               //                       child: Padding(
//                                                               //                         padding: EdgeInsets.all(12.0),
//                                                               //                         child: Text("Save"),
//                                                               //                       ),
//                                                               //                     ),
//                                                               //                   ),
//                                                               //                 ],
//                                                               //               ),
//                                                               //             )),
//                                                               //           );
//                                                               //         });
//                                                               //       },
//                                                               //     );
//                                                               //   },
//                                                               //   child:
//                                                               //       Container(
//                                                               //     width: MediaQuery.of(
//                                                               //                 context)
//                                                               //             .size
//                                                               //             .width *
//                                                               //         .95,
//                                                               //     height: 50,
//                                                               //     decoration:
//                                                               //         const BoxDecoration(
//                                                               //       border: Border(
//                                                               //           bottom: BorderSide(
//                                                               //               width:
//                                                               //                   .0001)),
//                                                               //       borderRadius:
//                                                               //           BorderRadius.all(
//                                                               //               Radius.circular(10)),
//                                                               //       color: Colors
//                                                               //           .white,
//                                                               //     ),
//                                                               //     child: Row(
//                                                               //       mainAxisAlignment:
//                                                               //           MainAxisAlignment
//                                                               //               .spaceBetween,
//                                                               //       children: [
//                                                               //         Row(
//                                                               //           children: [
//                                                               //             const SizedBox(
//                                                               //               width:
//                                                               //                   20,
//                                                               //             ),
//                                                               //             Text(
//                                                               //               formatMonths(selectedMonths),
//                                                               //               style:
//                                                               //                   TextStyle(
//                                                               //                 color: Colors.black.withOpacity(.5),
//                                                               //               ),
//                                                               //             ),
//                                                               //           ],
//                                                               //         ),
//                                                               //         SizedBox(
//                                                               //           width:
//                                                               //               60,
//                                                               //           child:
//                                                               //               Row(
//                                                               //             mainAxisAlignment:
//                                                               //                 MainAxisAlignment.end,
//                                                               //             children: [
//                                                               //               const Icon(
//                                                               //                 Icons.arrow_drop_down_sharp,
//                                                               //                 size: 30,
//                                                               //               ),
//                                                               //               GestureDetector(
//                                                               //                 onTap: () {
//                                                               //                   setState(() {
//                                                               //                     month = [];
//                                                               //                   });
//                                                               //                 },
//                                                               //                 child: Icon(
//                                                               //                   Icons.clear,
//                                                               //                   size: 20,
//                                                               //                   color: Colors.black.withOpacity(.5),
//                                                               //                 ),
//                                                               //               ),
//                                                               //               const SizedBox(
//                                                               //                 width: 10,
//                                                               //               ),
//                                                               //             ],
//                                                               //           ),
//                                                               //         ),
//                                                               //       ],
//                                                               //     ),
//                                                               //   ),
//                                                               // ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   await showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true,
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         height: MediaQuery.of(context).size.height *
//                                                                             .65,
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             .7,
//                                                                         child:
//                                                                             StatefulBuilder(
//                                                                           builder:
//                                                                               (context, setState) {
//                                                                             return Dialog(
//                                                                               child: Column(
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: ListView.builder(
//                                                                                       shrinkWrap: true,
//                                                                                       itemCount: _months.length,
//                                                                                       itemBuilder: (context, index) {
//                                                                                         return CheckboxListTile(
//                                                                                           title: Text(_months[index]),
//                                                                                           value: _isMonthChecked[index],
//                                                                                           onChanged: (val) {
//                                                                                             setState(() {
//                                                                                               _isMonthChecked[index] = val!;
//                                                                                               if (val) {
//                                                                                                 month.add(_months[index]);
//                                                                                               } else {
//                                                                                                 month.remove(_months[index]);
//                                                                                               }
//                                                                                               print("Selected Months: $month");
//                                                                                               selectedMonths = month.toString();
//                                                                                             });
//                                                                                           },
//                                                                                         );
//                                                                                       },
//                                                                                     ),
//                                                                                   ),
//                                                                                   GestureDetector(
//                                                                                     onTap: () {
//                                                                                       setState(() {
//                                                                                         selectedMonths = month.toString();
//                                                                                       });
//                                                                                       Navigator.pop(context, true);
//                                                                                     },
//                                                                                     child: const Padding(
//                                                                                       padding: EdgeInsets.all(8.0),
//                                                                                       child: Text("Save"),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             );
//                                                                           },
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(
//                                                                       () {});
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: month.length <=
//                                                                           1
//                                                                       ? 50
//                                                                       : (month.length *
//                                                                           30),
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                               width: 20),
//                                                                           month.isNotEmpty
//                                                                               ? Text(
//                                                                                   formatMonths(selectedMonths),
//                                                                                   style: TextStyle(
//                                                                                     color: Colors.black.withOpacity(.5),
//                                                                                   ),
//                                                                                 )
//                                                                               : Text(
//                                                                                   "Select Month",
//                                                                                   style: TextStyle(
//                                                                                     color: Colors.black.withOpacity(.5),
//                                                                                   ),
//                                                                                 ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             60,
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             const Icon(
//                                                                               Icons.arrow_drop_down_sharp,
//                                                                               size: 30,
//                                                                             ),
//                                                                             GestureDetector(
//                                                                               onTap: () {
//                                                                                 setState(() {
//                                                                                   month.clear();
//                                                                                   selectedMonths = "";
//                                                                                   _isMonthChecked = [
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                   ];
//                                                                                 });
//                                                                               },
//                                                                               child: Icon(
//                                                                                 Icons.clear,
//                                                                                 size: 20,
//                                                                                 color: Colors.black.withOpacity(.5),
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(width: 10),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   await showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true,
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         height: MediaQuery.of(context).size.height *
//                                                                             .65,
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             .7,
//                                                                         child:
//                                                                             StatefulBuilder(
//                                                                           builder:
//                                                                               (context, setState) {
//                                                                             return Dialog(
//                                                                               child: Column(
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: ListView.builder(
//                                                                                       shrinkWrap: true,
//                                                                                       itemCount: _texts.length,
//                                                                                       itemBuilder: (context, index) {
//                                                                                         return CheckboxListTile(
//                                                                                           title: Text(_texts[index]),
//                                                                                           value: _isChecked[index],
//                                                                                           onChanged: (val) {
//                                                                                             setState(() {
//                                                                                               _isChecked[index] = val!;
//                                                                                               if (val) {
//                                                                                                 day.add(_texts[index]);
//                                                                                               } else {
//                                                                                                 day.remove(_texts[index]);
//                                                                                               }
//                                                                                               print("Selected Days: $day");
//                                                                                               selectedDays = day.toString();
//                                                                                             });
//                                                                                           },
//                                                                                         );
//                                                                                       },
//                                                                                     ),
//                                                                                   ),
//                                                                                   GestureDetector(
//                                                                                     onTap: () {
//                                                                                       setState(() {
//                                                                                         selectedDays = day.toString();
//                                                                                       });
//                                                                                       Navigator.pop(context, true);
//                                                                                     },
//                                                                                     child: const Padding(
//                                                                                       padding: EdgeInsets.all(8.0),
//                                                                                       child: Text("Save"),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             );
//                                                                           },
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(
//                                                                       () {});
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: day.length <=
//                                                                           1
//                                                                       ? 50
//                                                                       : (day.length *
//                                                                           30),
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                               width: 20),
//                                                                           day.isNotEmpty
//                                                                               ? Text(
//                                                                                   formatDayss(selectedDays),
//                                                                                   style: TextStyle(
//                                                                                     color: Colors.black.withOpacity(.5),
//                                                                                   ),
//                                                                                 )
//                                                                               : Text(
//                                                                                   "Select Days",
//                                                                                   style: TextStyle(
//                                                                                     color: Colors.black.withOpacity(.5),
//                                                                                   ),
//                                                                                 ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             60,
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             const Icon(
//                                                                               Icons.arrow_drop_down_sharp,
//                                                                               size: 30,
//                                                                             ),
//                                                                             GestureDetector(
//                                                                               onTap: () {
//                                                                                 setState(() {
//                                                                                   day.clear();
//                                                                                   selectedDays = "";
//                                                                                   _isChecked = [
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false,
//                                                                                     false
//                                                                                   ];
//                                                                                 });
//                                                                               },
//                                                                               child: Icon(
//                                                                                 Icons.clear,
//                                                                                 size: 20,
//                                                                                 color: Colors.black.withOpacity(.5),
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(width: 10),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   GestureDetector(
//                                                                     onTap:
//                                                                         () async {
//                                                                       SharedPreferences
//                                                                           prefs1 =
//                                                                           await SharedPreferences
//                                                                               .getInstance();
//                                                                       var response = ApiServices.service.addschedule(
//                                                                           context,
//                                                                           merch,
//                                                                           month,
//                                                                           day,
//                                                                           "2024",
//                                                                           let);
//                                                                       response.then(
//                                                                           (value) =>
//                                                                               {
//                                                                                 Navigator.pop(context)
//                                                                               });
//                                                                       print(
//                                                                           "The passed values : $merch, $month, $day, $let");
//                                                                       prefs1.setString(
//                                                                           'merch',
//                                                                           "");
//                                                                       prefs1.setString(
//                                                                           "empName",
//                                                                           "");
//                                                                     },
//                                                                     child:
//                                                                         SizedBox(
//                                                                       width: MediaQuery.of(context)
//                                                                               .size
//                                                                               .width *
//                                                                           .19,
//                                                                       height:
//                                                                           40,
//                                                                       child: Card(
//                                                                           elevation: 0,
//                                                                           color: const Color(0XFFE84201),
//                                                                           shape: RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(8.0), //<-- SEE HERE
//                                                                           ),
//                                                                           child: const Center(
//                                                                               child: Text(
//                                                                             "SAVE",
//                                                                             style:
//                                                                                 TextStyle(color: Colors.white),
//                                                                           ))),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: MediaQuery.of(
//                                                                             context)
//                                                                         .size
//                                                                         .height *
//                                                                     .3,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   : Positioned(
//                                                       top: 60,
//                                                       left: 10,
//                                                       right: 10,
//                                                       child: Container(
//                                                         child:
//                                                             SingleChildScrollView(
//                                                           child: Column(
//                                                             children: [
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   SharedPreferences
//                                                                       prefs1 =
//                                                                       await SharedPreferences
//                                                                           .getInstance();
//                                                                   showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true, // user must tap button!
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         height: MediaQuery.of(context).size.height *
//                                                                             .85,
//                                                                         child:
//                                                                             Dialog(
//                                                                           child:
//                                                                               SingleChildScrollView(
//                                                                             child:
//                                                                                 SelectMerchandiser("2"),
//                                                                           ),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(() {
//                                                                     merch1 = prefs1
//                                                                         .get(
//                                                                             "merch1")
//                                                                         .toString();
//                                                                     empName1 = prefs1
//                                                                         .get(
//                                                                             "empName1")
//                                                                         .toString();
//                                                                   });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: 60,
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 20,
//                                                                           ),
//                                                                           Text(
//                                                                             merch1 == "" || merch1 == "null"
//                                                                                 ? "Select Merchandiser"
//                                                                                 : empName1,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       Row(
//                                                                         children: [
//                                                                           const Icon(
//                                                                             Icons.arrow_drop_down_sharp,
//                                                                             size:
//                                                                                 30,
//                                                                           ),
//                                                                           GestureDetector(
//                                                                             onTap:
//                                                                                 () async {
//                                                                               SharedPreferences prefs1 = await SharedPreferences.getInstance();
//                                                                               setState(() {
//                                                                                 merch1 = "";
//                                                                                 empName1 = "";
//                                                                                 prefs1.setString('merch1', "");
//                                                                                 prefs1.setString("empName1", "");
//                                                                               });
//                                                                             },
//                                                                             child:
//                                                                                 Icon(
//                                                                               Icons.clear,
//                                                                               size: 20,
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 10,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               GestureDetector(
//                                                                 onTap:
//                                                                     () async {
//                                                                   SharedPreferences
//                                                                       prefs1 =
//                                                                       await SharedPreferences
//                                                                           .getInstance();
//                                                                   showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true, // user must tap button!
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         height: MediaQuery.of(context).size.height *
//                                                                             .85,
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             .7,
//                                                                         child:
//                                                                             Dialog(
//                                                                           child:
//                                                                               SelectOutlets("2"),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                   setState(() {
//                                                                     out2 = prefs1
//                                                                         .get(
//                                                                             "out1")
//                                                                         .toString();
//                                                                     stores1 = prefs1
//                                                                         .get(
//                                                                             "store1")
//                                                                         .toString();
//                                                                     m = out2
//                                                                         .length;
//                                                                     out3 = out2
//                                                                         .substring(
//                                                                             1,
//                                                                             (m -
//                                                                                 1))
//                                                                         .split(
//                                                                             ',');
//                                                                     let1 = out3
//                                                                         .map(int
//                                                                             .parse)
//                                                                         .toList();
//                                                                     Preference
//                                                                         .setOutlets1(
//                                                                             []);
//                                                                   });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: m <= 2
//                                                                       ? 50
//                                                                       : double.parse(
//                                                                           "${10 * m}"),
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 20,
//                                                                           ),
//                                                                           Text(
//                                                                             out2 == ""
//                                                                                 ? "Select Outlets"
//                                                                                 : formatStoreNames(stores1),
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       Row(
//                                                                         children: [
//                                                                           const Icon(
//                                                                             Icons.arrow_drop_down_sharp,
//                                                                             size:
//                                                                                 30,
//                                                                           ),
//                                                                           GestureDetector(
//                                                                             onTap:
//                                                                                 () {
//                                                                               setState(() {
//                                                                                 out2 = "";
//                                                                                 m = 5;
//                                                                               });
//                                                                             },
//                                                                             child:
//                                                                                 Icon(
//                                                                               Icons.clear,
//                                                                               size: 20,
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 10,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               GestureDetector(
//                                                                 onTap: () {
//                                                                   showDialog<
//                                                                       void>(
//                                                                     context:
//                                                                         context,
//                                                                     barrierDismissible:
//                                                                         true, // user must tap button!
//                                                                     builder:
//                                                                         (BuildContext
//                                                                             context) {
//                                                                       return SizedBox(
//                                                                         height:
//                                                                             340,
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             .7,
//                                                                         child:
//                                                                             Dialog(
//                                                                           child:
//                                                                               Container(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             height:
//                                                                                 340,
//                                                                             child:
//                                                                                 Column(
//                                                                               children: [
//                                                                                 SfDateRangePicker(
//                                                                                   view: DateRangePickerView.month,
//                                                                                   allowViewNavigation: false,
//                                                                                   onSelectionChanged: _onSelectionChanged,
//                                                                                   selectionMode: DateRangePickerSelectionMode.single,
//                                                                                   backgroundColor: Colors.black12,
//                                                                                   headerHeight: 60,
//                                                                                   selectionColor: const Color(0XFFE84201),
//                                                                                   headerStyle: const DateRangePickerHeaderStyle(
//                                                                                     textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
//                                                                                     textAlign: TextAlign.center,
//                                                                                     backgroundColor: Color(0XFFE84201),
//                                                                                   ),
//                                                                                 ),
//                                                                                 GestureDetector(
//                                                                                   onTap: () {
//                                                                                     Navigator.pop(context);
//                                                                                   },
//                                                                                   child: const Row(
//                                                                                     mainAxisAlignment: MainAxisAlignment.end,
//                                                                                     children: [
//                                                                                       Padding(
//                                                                                         padding: EdgeInsets.all(8.0),
//                                                                                         child: Text("Ok    "),
//                                                                                       ),
//                                                                                     ],
//                                                                                   ),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   );
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       .95,
//                                                                   height: 60,
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                     border: Border(
//                                                                         bottom: BorderSide(
//                                                                             width:
//                                                                                 .0001)),
//                                                                     borderRadius:
//                                                                         BorderRadius.all(
//                                                                             Radius.circular(10)),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 20,
//                                                                           ),
//                                                                           Text(
//                                                                             "Select Date",
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.black.withOpacity(.5),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       Row(
//                                                                         children: [
//                                                                           Text(
//                                                                             _selectedDate == ""
//                                                                                 ? ""
//                                                                                 : _selectedDate.substring(0, 10).toString(),
//                                                                             style:
//                                                                                 const TextStyle(color: Colors.black, fontSize: 13),
//                                                                           ),
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 5,
//                                                                           ),
//                                                                           const Icon(
//                                                                             Icons.calendar_month,
//                                                                             size:
//                                                                                 20,
//                                                                             color:
//                                                                                 Colors.black,
//                                                                           ),
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 10,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 20,
//                                                               ),
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   GestureDetector(
//                                                                     onTap: () {
//                                                                       var response = ApiServices.service.addunschedule(
//                                                                           context,
//                                                                           merch1,
//                                                                           _selectedDate
//                                                                               .substring(0, 10)
//                                                                               .toString(),
//                                                                           let1);
//                                                                       response.then(
//                                                                           (value) =>
//                                                                               {
//                                                                                 Navigator.pop(context)
//                                                                               });
//                                                                     },
//                                                                     child:
//                                                                         SizedBox(
//                                                                       width: MediaQuery.of(context)
//                                                                               .size
//                                                                               .width *
//                                                                           .19,
//                                                                       height:
//                                                                           50,
//                                                                       child: Card(
//                                                                           elevation: 0,
//                                                                           color: const Color(0XFFE84201),
//                                                                           shape: RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(8.0), //<-- SEE HERE
//                                                                           ),
//                                                                           child: const Center(
//                                                                               child: Text(
//                                                                             "SAVE",
//                                                                             style:
//                                                                                 TextStyle(color: Colors.white),
//                                                                           ))),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: SizedBox(
//             height: 40,
//             width: MediaQuery.of(context).size.width * .25,
//             child: FloatingActionButton(
//               backgroundColor: const Color(0xfff5e1d5),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AddWeekPage()),
//                 );
//               },
//               child: const Text(
//                 "Week Off",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0XFFE84201),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
