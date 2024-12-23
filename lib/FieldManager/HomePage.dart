// import 'package:flutter/material.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:rms/Employee/ApiService.dart';
// import 'package:rms/Employee/LoginPage.dart';
// import 'package:rms/FieldManager/ApiService.dart';
// import 'package:rms/FieldManager/JourneyManager.dart';
// import 'package:rms/FieldManager/OutletPage.dart';
// import 'package:rms/FieldManager/ReliverPage.dart';
// import 'package:rms/FieldManager/ReportsPage.dart';
// import 'package:rms/FieldManager/TimesheetPage.dart';
// import 'package:rms/NetworkModelfm/DashboardFm_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   DashboardFmModel? dashboardFmModel;

//   HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState(dashboardFmModel);
// }

// class _HomePageState extends State<HomePage> {
//   String  userName="";
//   String emp="";
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   DashboardFmModel? dashboardFmModel;
//   _HomePageState(DashboardFmModel? dashboardFmModel);
//   _getdashboard() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     userName = prefs1.get("user").toString();
//     emp = prefs1.get("id").toString();
//     await ApiServices.service.dashboard(context).then((value) => {
//           setState(() {
//             dashboardFmModel = value;
//           })
//         });
//   }

//   bool _isLoaderVisible = false;
//   Future<void> loader() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     context.loaderOverlay.show();
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//     await Future.delayed(const Duration(seconds: 5));
//     if (_isLoaderVisible) {
//       context.loaderOverlay.hide();
//     }
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//   }

//   loadVals() async {
//     await _getdashboard();
//   }

//   @override
//   initState() {
//     super.initState();
//     loadVals();
//     loader();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 3,
//         backgroundColor: const Color(0xfff5e1d5),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                     onTap: () => scaffoldKey.currentState?.openDrawer(),
//                     child: Image.asset(
//                       "images/NewRMSMenu.png",
//                       width: 34,
//                       height: 25,
//                       fit: BoxFit.fill,
//                     )),
//                 const SizedBox(
//                   width: 14,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       "images/rmsLogo.png",
//                       width: 70,
//                       height: 35,
//                       fit: BoxFit.fill,
//                     ),
//                     Text(
//                       userName+"("+emp+")",
//                       style: const TextStyle(fontSize: 8),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/Pattern.png"),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: SingleChildScrollView(
//             child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 1,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => JourneyManager()),
//                     );
//                   },
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: Card(
//                       elevation: 0,
//                       color: const Color(0xfff5e1d5),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 8),
//                           const Text(
//                             "Perfomance Indicator",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 const SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .28,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: const Center(
//                                           child: Text("Merchandisers")),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                           dashboardFmModel==null?"": dashboardFmModel!.merchandiser
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Total",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .18,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"":dashboardFmModel!
//                                                 .merchandiserPresent
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Present",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"":dashboardFmModel!.merchandiserAbsent
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Absent",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .28,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: const Center(
//                                           child: Text("Total Outlets")),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"": dashboardFmModel!.totalOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Total",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .18,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"": dashboardFmModel!
//                                                 .totalCompletedOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Completed",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             //                   <--- left side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"": dashboardFmModel!
//                                                 .totalPendingOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Pending",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .28,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: const Center(
//                                           child: Text("Today Outlets")),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"":dashboardFmModel!.todayOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Total",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .18,
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           right: BorderSide(
//                                             //                    <--- top side
//                                             color: Colors.black,
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"":dashboardFmModel!
//                                                 .todayCompletedOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Completed",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                     SizedBox(
//                                       height: 50,
//                                       width: MediaQuery.of(context).size.width *
//                                           .2,
//                                       child: Center(
//                                           child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             dashboardFmModel==null?"": dashboardFmModel!
//                                                 .todayPendingOutlets
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                           const Text("Pending",
//                                               style: TextStyle(
//                                                   fontSize: 10, height: .8)),
//                                         ],
//                                       )),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => OutletPage()),
//                         );
//                       },
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 20.0, bottom: 20, right: 45, left: 45),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.business_outlined,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Outlets"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => JourneyManager()),
//                         );
//                       },
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 20.0, bottom: 20, right: 30, left: 30),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.directions_bus_outlined,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Journey Plan"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => TimeSheetPage()),
//                         );
//                       },
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 20.0, bottom: 20, right: 35, left: 35),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.auto_graph,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Time Sheet"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ReportsPage()),
//                         );
//                       },
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 20.0, bottom: 20, right: 45, left: 45),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.list_alt_rounded,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Reports"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RelieverPage()),
//                         );
//                       },
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 20.0, bottom: 20, right: 45, left: 45),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.person_add_rounded,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Reliever"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 100,
//                       width: MediaQuery.of(context).size.width * .93,
//                       child: const Card(
//                         color: Color(0xfff5e1d5),
//                         elevation: 0,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 15.0, bottom: 15, right: 30, left: 30),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.light_mode_outlined,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                   "Welcome to the new field \nmanager interface of RMS. Hope \nyou have a great day ahead."),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             DrawerHeader(
//                 decoration: const BoxDecoration(
//                   color: Color(0XFFE84201),
//                 ), //BoxDecoration
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircleAvatar(
//                       radius: 30,
//                       child: CircleAvatar(
//                         radius: 26,
//                         backgroundColor: Color(0XFFE84201),
//                         child: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "Menu",
//                       style: TextStyle(color: Colors.white, fontSize: 22),
//                     ),
//                     Text(userName!,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         )),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                   ],
//                 ) //UserAccountDrawerHeader
//                 ), //DrawerHeader
//             ListTile(
//               leading: const Icon(
//                 Icons.person,
//                 size: 25,
//               ),
//               title: const Text(
//                 ' Profile ',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               onTap: () {},
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.calendar_month, size: 25),
//               title: const Text(
//                 ' Logs ',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.privacy_tip, size: 25),
//               title: const Text(
//                 ' RMS Version ',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout, size: 25),
//               title: const Text(
//                 'Log Out',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               onTap: () {
//                 var response = ApiService.service.logout(context);
//                 response.then((value) => {
//                       setState(() {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginPage()),
//                         );
//                       }),
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Center(
//                               child: Text(
//                                   "You have successfully logged out!")),
//                           backgroundColor: Color(0XFFE84201),
//                         ),
//                       ),
//                     });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/LoginPage.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/JourneyManager.dart';
import 'package:rms/FieldManager/LeaveManage.dart';
import 'package:rms/FieldManager/OutOfStockDetails.dart';
import 'package:rms/FieldManager/OutletPage.dart';
import 'package:rms/FieldManager/ReliverPage.dart';
import 'package:rms/FieldManager/ReportsPage.dart';
import 'package:rms/FieldManager/TimesheetPage.dart';
import 'package:rms/NetworkModelfm/DashboardFm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class HomePage extends StatefulWidget {
  DashboardFmModel? dashboardFmModel;

  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState(dashboardFmModel);
}

class _HomePageState extends State<HomePage> {
  String  userName="";
  String emp="";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardFmModel? dashboardFmModel;
  _HomePageState(DashboardFmModel? dashboardFmModel);
  _getdashboard() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    await ApiServices.service.dashboard(context).then((value) => {
          setState(() {
            dashboardFmModel = value;
          })
        });
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 5));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  loadVals() async {
    await _getdashboard();
  }

  @override
  initState() {
    super.initState();
    loadVals();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => scaffoldKey.currentState?.openDrawer(),
                    child: Image.asset(
                      "images/NewRMSMenu.png",
                      width: 34,
                      height: 25,
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/rmsLogo.png",
                      width: 70,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      userName+"("+emp+") - New Version"+AppVersion.version,
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Pattern.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JourneyManager("1")),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xfff5e1d5),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            "Perfomance Indicator",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .28,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text("Merchandisers")),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                          dashboardFmModel==null?"": dashboardFmModel!.merchandiser
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Total",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"":dashboardFmModel!
                                                .merchandiserPresent
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Present",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"":dashboardFmModel!.merchandiserAbsent
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Absent",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .28,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text("Total Outlets")),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"": dashboardFmModel!.totalOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Total",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"": dashboardFmModel!
                                                .totalCompletedOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Completed",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"": dashboardFmModel!
                                                .totalPendingOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Pending",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .28,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text("Today Outlets")),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"":dashboardFmModel!.todayOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Total",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            //                    <--- top side
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"":dashboardFmModel!
                                                .todayCompletedOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Completed",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dashboardFmModel==null?"": dashboardFmModel!
                                                .todayPendingOutlets
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const Text("Pending",
                                              style: TextStyle(
                                                  fontSize: 10, height: .8)),
                                        ],
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OutletPage()),
                        );
                      },
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20, right: 45, left: 45),
                          child: Column(
                            children: [
                              Icon(
                                Icons.business_outlined,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Outlets"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JourneyManager("1")),
                        );
                      },
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20, right: 30, left: 30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.directions_bus_outlined,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Journey Plan"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimeSheetPage()),
                        );
                      },
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20, right: 35, left: 35),
                          child: Column(
                            children: [
                              Icon(
                                Icons.auto_graph,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Time Sheet"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportsPage()),
                        );
                      },
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20, right: 45, left: 45),
                          child: Column(
                            children: [
                              Icon(
                                Icons.list_alt_rounded,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Reports"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RelieverPage()),
                        );
                      },
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20, right: 45, left: 45),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add_rounded,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Reliever"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => OutOfStockDetails()),
                    //     );
                    //   },
                    //   child: const Card(
                    //     color: Color(0xfff5e1d5),
                    //     elevation: 0,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(
                    //           top: 20.0, bottom: 20, right: 30, left: 30),
                    //       child: Column(
                    //         children: [
                    //           Icon(
                    //             Icons.warehouse_outlined,
                    //             size: 50,
                    //           ),
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           Text("Out of Stock"),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * .93,
                      child: const Card(
                        color: Color(0xfff5e1d5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, bottom: 15, right: 30, left: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.light_mode_outlined,
                                size: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  "Welcome to the new field \nmanager interface of RMS. Hope \nyou have a great day ahead."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0XFFE84201),
                ), //BoxDecoration
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0XFFE84201),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Menu",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(userName!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ) //UserAccountDrawerHeader
                ), //DrawerHeader
            // ListTile(
            //   leading: const Icon(
            //     Icons.person,
            //     size: 25,
            //   ),
            //   title: const Text(
            //     ' Profile ',
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            //   onTap: () {},
            // ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.calendar_month, size: 25),
            //   title: const Text(
            //     ' Logs ',
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.privacy_tip, size: 25),
            //   title: const Text(
            //     ' RMS Version ',
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, size: 25),
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                var response = ApiService.service.logout(context);
                response.then((value) => {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }),
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                              child: Text(
                                  "You have successfully logged out!")),
                          backgroundColor: Color(0XFFE84201),
                        ),
                      ),
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
