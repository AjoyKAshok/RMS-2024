// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Availability extends StatefulWidget {

//   @override
//   State<Availability> createState() => _AvailabilityState();
// }

// class _AvailabilityState extends State<Availability> {
// int i =0;
// String dropdownvalue = 'Category';
// String dropdownvalue1 = 'Brand';
// String dropdownvalue2 = 'Select\nReason';
// bool light = false;
// // List of items in our dropdown menu
// var items = [
//   'Category',
//   'PET FOOD',
//   'BISCUITS',
//   'CAKES',
//   'LIMITED',
// ];
//   var items1 = [
//     'Brand',
//     'KITE KAT',
//     'SHEBA',
//     'TRILL',
//     'GALAXY',
//   ];
//   var items2 = [
//     'Select\nReason',
//     'Item Expired',
//     'Out of Stock',
//     'Not Listed',
//     'GALAXY',
//   ];
// @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         elevation: 1,
//         foregroundColor: Colors.black.withOpacity(.6),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Availability",style: TextStyle(color:Color(0XFFE84201),fontSize: 24,fontWeight: FontWeight.w500),),
//                    // Text("Roja Ramanan(Emp7325)-MRCH4.4.15",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 8,fontWeight: FontWeight.w500),),
//                   ],
//                 ),
//             Row(
//               children: [
//                 IconButton(onPressed: (){},
//                     icon: Icon(Icons.refresh,size: 30,)),
//                 SizedBox(width: 10,),
//                 GestureDetector(
//                   onTap: (){},
//                   child: Card(
//                       elevation: 0,
//                       color: Color(0XFFE84201).withOpacity(.6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15,right: 15,top: 6,bottom: 6),
//                         child: Text("Submit",style: TextStyle(color: Colors.white),),
//                       )),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("images/Pattern.png"),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Container(
//               child:Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     Card(
//                       elevation: 0,
//                       color: Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Icon(Icons.home_filled,size: 40,),
//                             SizedBox(width: 10,),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("[10345611] C4 - CENTURY MALL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
//                                 Text("city land Dubai UAE",style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 12),),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                            Container(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width*.44,
//                                 child: Card(
//                                   color: Colors.white,
//                                   elevation: 0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         // Initial Value
//                                         value: dropdownvalue,

//                                         // Down Arrow Icon
//                                         icon: Padding(
//                                           padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.1),
//                                           child: Icon(Icons.arrow_drop_down_sharp,size: 25,color: Color(0XFFE84201),),
//                                         ),

//                                         // Array list of items
//                                         items: items.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(items),
//                                           );
//                                         }).toList(),
//                                         // After selecting the desired option,it will
//                                         // change button value to selected value
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownvalue = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                              Container(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width*.44,
//                                 child: Card(
//                                   color: Colors.white,
//                                   elevation: 0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(

//                                         // Initial Value
//                                         value: dropdownvalue1,

//                                         // Down Arrow Icon
//                                         icon: Padding(
//                                           padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.1),
//                                           child: Icon(Icons.arrow_drop_down_sharp,size: 25,color: Color(0XFFE84201),),
//                                         ),

//                                         // Array list of items
//                                         items: items1.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(items),
//                                           );
//                                         }).toList(),
//                                         // After selecting the desired option,it will
//                                         // change button value to selected value
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownvalue1 = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ),
//                           ],
//                         ),
//                     SizedBox(height: 10,),
//                     Container(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           color: Colors.white,
//                           elevation: 0,
//                           child:TextField(
//                             cursorColor: Color(0XFFE84201),
//                             style: TextStyle(color:Color(0XFFE84201) ),
//                             decoration: InputDecoration(
//                               hintText: "Search by product code/ZERP code",
//                               hintStyle: TextStyle(color:Color(0XFFE84201) ),
//                               border: InputBorder.none,
//                               prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
//                               suffixIcon: Icon(Icons.clear,color:Color(0XFFE84201)),
//                             ),
//                           ),)),
//                     SizedBox(height: 10,),
//                     Card(
//                       elevation: 0,
//                       color: Color(0XFFE84201).withOpacity(.2),
//                       child:  Column(
//                           children: [
//                             Container(
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10) ),
//                                 color: Color(0XFFE84201),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Item/Description",style: TextStyle(color: Colors.white,fontSize: 16),),
//                                     Text("Avl",style: TextStyle(color: Colors.white,fontSize: 16),),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 children: [
//                                 Container(
//                                   height:MediaQuery.of(context).size.height*.5,
//                                   child: ListView.builder(
//                                   itemCount: 3,
//                                   itemBuilder: (BuildContext context, int index) {
//                                   return SingleChildScrollView(
//                                     child: Row(
//                                         children: [
//                                           Container(
//                                               width:MediaQuery.of(context).size.width*.42,
//                                               height: 60,
//                                               decoration: BoxDecoration(
//                                                 border: Border(
//                                                   right: BorderSide( //                   <--- left side
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   bottom: BorderSide( //                    <--- top side
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(right:5,bottom: 5,top: 5),
//                                                 child: Text("Galaxy Cake caramel 30g [188193]",style: TextStyle(fontSize: 12),),
//                                               )),
//                                           Container(
//                                               width:MediaQuery.of(context).size.width*.2,
//                                               height: 60,
//                                               decoration: BoxDecoration(
//                                                 border: Border(
//                                                   right: BorderSide( //                   <--- left side
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   bottom: BorderSide( //                    <--- top side
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                 ),
//                                               ),
//                                             child: Switch(
//                                               // This bool value toggles the switch.
//                                               value: light,
//                                               activeColor: Colors.red,
//                                               inactiveThumbColor: Colors.white,
//                                               inactiveTrackColor: Colors.green,
//                                               onChanged: (bool value) {
//                                                 // This is called when the user toggles the switch.
//                                                 setState(() {
//                                                   light = value;
//                                                 });
//                                               },
//                                             ),
//                                               ),
//                                           Container(
//                                             width:MediaQuery.of(context).size.width*.235,
//                                             height: 60,
//                                             decoration: BoxDecoration(
//                                               border: Border(
//                                                 bottom: BorderSide( //                    <--- top side
//                                                   color: Colors.black,
//                                                   width: 1.0,
//                                                 ),
//                                               ),
//                                             ),
//                                             child: DropdownButtonHideUnderline(
//                                               child: DropdownButton(

//                                                 // Initial Value
//                                                 value: dropdownvalue2,

//                                                 // Down Arrow Icon
//                                                 icon:  light==true?Icon(Icons.arrow_drop_down_sharp,size: 18,color: Color(0XFFE84201),):Container(),


//                                                 // Array list of items
//                                                 items: items2.map((String items) {
//                                                   return DropdownMenuItem(
//                                                     value: items,
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.only(left: 5.0),
//                                                       child: light==true?Text(items,style: TextStyle(fontSize: 12),):Container(),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                                 // After selecting the desired option,it will
//                                                 // change button value to selected value
//                                                 onChanged: (String? newValue) {
//                                                   setState(() {
//                                                     dropdownvalue2 = newValue!;
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                   );}),
//                                 ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                     )
//                   ],
//                 ),
//               )
//           )
//       ),
//     );
//   }
// }