// import 'package:flutter/material.dart';
// import 'package:rms/Employee/ApiService.dart';
// import 'package:rms/Employee/JourneyPlan.dart';
// import 'package:rms/Employee/Preference.dart';
// import 'package:rms/FieldManager/ApiService.dart';
// // import 'package:rms/FieldManager/JourneyManager.dart';
// import 'package:rms/NetworkModel/WeekplannedJourney_Model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:rms/NetworkModelfm/Outlet_model.dart';

// class SelectUnscheduledOutlets extends StatefulWidget {
//   Data? data;
//   String j = "";
//   SelectUnscheduledOutlets(this.j, {super.key});
//   @override
//   State<SelectUnscheduledOutlets> createState() =>
//       _SelectUnscheduledOutletsState(data, j);
// }

// class _SelectUnscheduledOutletsState extends State<SelectUnscheduledOutlets> {
//   int i = 0;
//   String j = "";
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   var journeyPlanList = [];
//   var filteredList = [];
//   var filteredList1 = [];
//   final TextEditingController _sea = TextEditingController();
//   List<String> name = [];
//   List<String> storeName = [];
//   Map<String, dynamic>? theStore;
//   List<Map<String, dynamic>> stores = [];
//   List<Map<String, dynamic>> uniqueStores = [];
//   var date = DateTime.timestamp();
//   var todayDate = DateTime.now();
//   Set<String> outletIds = {};
//   // OutletModel? _outletModel;
//   WeekplannedJourneyModel? _data;
//   String? empToken;
//   String? empId;

//   _SelectUnscheduledOutletsState(Data? data, this.j);

//   _getplanned() {
//     ApiService.service.weekplannedJourney(context).then((value) => {
//           setState(() {
//             _data = value;
//             myList.addAll(_data!.data!);
//             lengthlist = myList.length;
//             _isChecked = List<bool>.filled(_data!.data!.length, false);
//             for (var i = 0; i < lengthlist; i++) {
//               print("The Weeks JP List : ${_data!.data![i].storeName}");
//               theStore = {
//                 "outlet_id": _data!.data![i].outletId.toString(),
//                 "store_name": _data!.data![i].storeName,
//                 "store_code": _data!.data![i].storeCode,
//               };
//               stores.add(theStore!);
//             }

//             print("The List of Stores in the Week : $stores");

//             for (var item in stores) {
//               print("Item Details : $item");
//               if (!outletIds.contains(item['outlet_id'])) {
//                 outletIds.add(item['outlet_id']);
//                 uniqueStores.add(item);
//               }
//             }
//             print("The Unique List : $uniqueStores");

//             for (var i = 0; i < uniqueStores.length; i++) {
//               filteredList.add(
//                   "${uniqueStores[i]['outlet_id']} / ${uniqueStores[i]['store_code']} / ${uniqueStores[i]['store_name']}");
//             }
//           }),
//         });
//   }

//   getVals() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     empId = (await Preference.getid());
//   }

//   void _filterItems(String query) {
//     var results = [];
//     if (query.isEmpty) {
//       results = filteredList;
//     } else {
//       results = filteredList
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }

//     setState(() {
//       filteredList1 = results;
//     });
//   }

//   List<bool>? _isChecked;
//   @override
//   initState() {
//     super.initState();
//     // _gettodayplanned();
//     _getplanned();
//     getVals();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height * .90,
//             child: SingleChildScrollView(
//           physics: const NeverScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text("Select Outlets", style: TextStyle(fontWeight: FontWeight.bold),),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _sea,
//                   decoration: const InputDecoration(
//                     labelText: 'Search',
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (value) {
//                     _filterItems(value);
//                     setState(() {
//                       i = 1;
//                     });
//                   },
//                 ),
//               ),
//               i == 0
//                   ? SizedBox(
//                       height: MediaQuery.of(context).size.height * .68,
//                       child: ListView.builder(
//                           physics: const ScrollPhysics(),
//                           itemCount: uniqueStores.length,
//                           shrinkWrap: true,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0),
//                                       child: CheckboxListTile(
//                                         title: SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .8,
//                                             child: Text(
//                                               "[${uniqueStores[index]['store_code']}] ${uniqueStores[index]['store_name']}",
//                                               style:
//                                                   const TextStyle(fontSize: 13),
//                                             )),
//                                         value: _isChecked![index],
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             _isChecked![index] = newValue!;
//                                             name.add(uniqueStores[index]
//                                                     ['outlet_id']
//                                                 .toString());
//                                             storeName.add(uniqueStores[index]
//                                                     ['store_name']
//                                                 .toString());
//                                             print("Store Names : $storeName");
//                                           });
//                                         },
//                                         controlAffinity: ListTileControlAffinity
//                                             .leading, //  <-- leading Checkbox
//                                       ),
//                                     ),
//                                   ),
//                                   // SizedBox(height: 05,),
//                                 ],
//                               ),
//                             );
//                           }),
//                     )
//                   : SizedBox(
//                       height: MediaQuery.of(context).size.height * .68,
//                       child: ListView.builder(
//                           physics: const ScrollPhysics(),
//                           itemCount: filteredList1.length,
//                           shrinkWrap: true,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0),
//                                       child: CheckboxListTile(
//                                         title: SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .8,
//                                             child: Text(
//                                               "${filteredList1[index].split(" / ")[1]} - ${filteredList1[index].split(" / ")[2]}",
//                                               style:
//                                                   const TextStyle(fontSize: 13),
//                                             )),
//                                         value: _isChecked![index],
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             _isChecked![index] = newValue!;
//                                             name.add(filteredList1[index]
//                                                 .split(" / ")[0]
//                                                 .toString());
//                                             storeName.add(filteredList1[index]
//                                                 .split(" / ")[2]
//                                                 .toString());
//                                             print(" Names : $name");
//                                             print("Store Names : $storeName");
//                                           });
//                                         },
//                                         controlAffinity: ListTileControlAffinity
//                                             .leading, //  <-- leading Checkbox
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                     ),
//             ],
//           ),
//         )),
//         SizedBox(
//           height: 15,
//         ),
//         Positioned(
//           bottom: 0,
//           left: 15,
//           right: 15,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12, bottom: 12),
//             child: GestureDetector(
//               onTap: () {
//                 var response = ApiServices.service.addunschedule(context, empId,
//                     todayDate.toString().substring(0, 10), name);
//                 response.then((value) => {
//                   print("The value of response : ${value.data}"),
//                   value.data == false 
//           ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Center(child: Text("One or More Outlets Selected Already Exists in Journey Plan.")),
//               backgroundColor: Colors.red,
//             ))
//           : 
//                       // Navigator.pop(context),
//                        Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JourneyPlan(0)),
//                 ),
//                       // j == "0"
//                       //     ? Navigator.of(context).pushReplacement(
//                       //         MaterialPageRoute(
//                       //             builder: (BuildContext context) =>
//                       //                 JourneyManager("1")))
//                       //     : Navigator.of(context).pushReplacement(
//                       //         MaterialPageRoute(
//                       //             builder: (BuildContext context) =>
//                       //                 JourneyManager("2"))),
//                     });
//                 print(
//                     "The values to be passed : Outlet Ids - $name, EmpId : $empId, Date: ${todayDate.toString().substring(0, 10)} ");
//               },
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Card(
//                     color: Color(0XFFE84201),
//                     child: Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: Text(
//                         "Add Unscheduled JP",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
