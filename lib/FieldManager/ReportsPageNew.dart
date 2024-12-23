// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:rms/Employee/ApiService.dart';
// import 'package:rms/FieldManager/ApiService.dart';
// import 'package:rms/NetworkModelfm/Report_model.dart';


// class ReportsPage extends StatefulWidget {
//   Data? data;
//   @override
//   State<ReportsPage> createState() => _ReportsPageState(this.data);
// }

// class _ReportsPageState extends State<ReportsPage> {
//   int i=0;
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   var date= DateTime.timestamp();
//   ReportModel? _data;
//   _ReportsPageState(Data? data);
//   _gettodayplanned() {
//     ApiServices.service.report(context).then((value) => {
//       setState(() {
//         _data = value;
//         myList.addAll(_data!.data!);
//         lengthlist = myList.length;
//       })
//     });
//   }
//   @override
//   initState() {
//     super.initState();
//     _gettodayplanned();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 3,
//         backgroundColor: Color(0xfff5e1d5),
//         foregroundColor:  Color(0XFFE84201),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("Reports"),
//             Text("SALEESH BHAMDARI HIRA(RMS0081)-FM4-4-16",style: TextStyle(fontSize: 9,color: Colors.black),),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("images/Pattern.png"),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child:  Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               children: [
//                 SizedBox(height: 10,),
//                 Container(
//                   height: 60,
//                   width: MediaQuery.of(context).size.width*.94,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50.0),
//                     color:  Color(0xfff5e1d5),
//                   ),
//                   padding: EdgeInsets.all(8),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search by Outlet Name/Code',
//                       hintStyle: TextStyle(color:Color(0XFFE84201),),
//                       border:InputBorder.none,
//                       prefixIcon: Icon(Icons.search,color: Color(0XFFE84201),size: 30,),
//                       suffixIcon: Icon(Icons.clear,color: Color(0XFFE84201),size: 25,),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: lengthlist,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 6.0),
//                         child: Card(
//                           elevation: 0,
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(_data!.data![index].storeName.toString()+" - "+_data!.data![index].storeCode.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),),
//                                 SizedBox(height: 2,),
//                                 Text("Date : "+_data!.data![index].date.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
//                                 SizedBox(height: 2,),
//                                 Text("Visit Type : "+_data!.data![index].checkinType.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
//                                 SizedBox(height: 2,),
//                                 Text("CheckIn Time : "+_data!.data![index].checkinTime.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
//                                 SizedBox(height: 2,),
//                                 Text("CheckOut Time : "+_data!.data![index].checkoutTime.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
//                                 SizedBox(height: 2,),
//                                 Text("Visited By : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
//                                 //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }