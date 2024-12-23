



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:rms/Employee/Preference.dart';

// import 'package:rms/FieldManager/ApiService.dart';
// import 'package:rms/FieldManager/JourneyManager.dart';
// import 'package:rms/NetworkModelfm/Outlet_model.dart';

// class SelectOutlets extends StatefulWidget {
//   Data? data;
//   String j="";
//   SelectOutlets(this.j);
//   @override
//   State<SelectOutlets> createState() => _SelectOutletsState(this.data,this.j);
// }

// class _SelectOutletsState extends State<SelectOutlets> {
//   int i = 0;
//   String j="";
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   var filteredList = [];
//   var filteredList1 = [];
//   final TextEditingController _sea = TextEditingController();
//   List<String> name = [];
//   List<String> storeName = [];
//   var date = DateTime.timestamp();
//   OutletModel? _outletModel;
//   _SelectOutletsState(Data? data,this.j);
//   _gettodayplanned() {
//     ApiServices.service
//         .outlet(
//           context,
//         )
//         .then((value) => {
//               setState(() {
//                 _outletModel = value;
//                 myList.addAll(_outletModel!.data!);
//                 lengthlist = myList.length;
//                 _isChecked = List<bool>.filled(_outletModel!.data!.length, false);
//                 for (int i = 0; i < lengthlist; i++) {
//                   filteredList.add(_outletModel!.data![i].outletId.toString()+_outletModel!.data![i].store![0].storeCode.toString()+" - "+ _outletModel!.data![i].store![0].storeName.toString());
//                 }
//               })
//             });
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
//     _gettodayplanned();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: SingleChildScrollView(
//           child: Column(
//                 children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text("Select Outlets"),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _sea,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 _filterItems(value);
//                 setState(() {
//                   i=1;
//                 });
//               },
//             ),
//           ),
//           i==0?Container(
//             height: MediaQuery.of(context).size.height * .68,
//             child: ListView.builder(
//                 physics: ScrollPhysics(),
//                 itemCount: lengthlist,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Padding(
//                             padding: const EdgeInsets.all(0),
//                             child: CheckboxListTile(
//                               title: Container(
//                                   width: MediaQuery.of(context).size.width * .8,
//                                   child: Text(
//                                     "[" +
//                                         _outletModel!
//                                             .data![index].store![0].storeCode
//                                             .toString() +
//                                         "] " +
//                                         _outletModel!
//                                             .data![index].store![0].storeName
//                                             .toString(),
//                                     style: TextStyle(fontSize: 13),
//                                   )),
//                               value: _isChecked![index],
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   _isChecked![index] = newValue!;
//                                   name.add(_outletModel!.data![index].outletId
//                                       .toString());
//                                   storeName.add(_outletModel!
//                                       .data![index].store![0].storeName
//                                       .toString());
//                                   print("Store Names : $storeName");
//                                 });
//                               },
//                               controlAffinity: ListTileControlAffinity
//                                   .leading, //  <-- leading Checkbox
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ):Container(
//             height: MediaQuery.of(context).size.height * .68,
//             child: ListView.builder(
//                 physics: ScrollPhysics(),
//                 itemCount: filteredList1.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Padding(
//                             padding: const EdgeInsets.all(0),
//                             child: CheckboxListTile(
//                               title: Container(
//                                   width: MediaQuery.of(context).size.width * .8,
//                                   child: Text(
//                                     filteredList1[index].toString().substring(2),
//                                     style: TextStyle(fontSize: 13),
//                                   )),
//                               value: _isChecked![index],
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   _isChecked![index] = newValue!;
//                                   name.add(filteredList1[index].toString().substring(0,2));
//                                   storeName.add(filteredList1[index].toString().substring(12));
//                                   print(" Names : $name");
//                                   print("Store Names : $storeName");
//                                 });
//                               },
//                               controlAffinity: ListTileControlAffinity
//                                   .leading, //  <-- leading Checkbox
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   // merch=_data!.data![index].firstName.toString();
//                   //Provider.of<AppProvider>(context, listen: false).setToken(userid);
//                   j=="0"?Preference.setOutlets(name):j=="2"?Preference.setOutlets1(name):Preference.setOutlets(name);
//                   j=="0"?Preference.setStores(storeName):j=="2"?Preference.setStores1(storeName):Preference.setStores(storeName);
//                 });
//                 Navigator.pop(context);
//                 j=="0"?Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (BuildContext context) => JourneyManager("1"))):Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (BuildContext context) => JourneyManager("2")));
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 18.0),
//                     child: Text("Save"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//                 ],
//               ),
//         ));
//   }
// }
