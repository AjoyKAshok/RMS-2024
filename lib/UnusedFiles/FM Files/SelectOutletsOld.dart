// import 'package:flutter/material.dart';
// import 'package:rms/Employee/Preference.dart';
// import 'package:rms/FieldManager/ApiService.dart';
// import 'package:rms/FieldManager/JourneyManager.dart';
// import 'package:rms/NetworkModelfm/Outlet_model.dart';

// class SelectOutlets extends StatefulWidget {
//   Data? data;

//   SelectOutlets({super.key});
//   @override
//   State<SelectOutlets> createState() => _SelectOutletsState(data);
// }

// class _SelectOutletsState extends State<SelectOutlets> {
//   int i = 0;
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   List<String> name = [];
//   List<String> storeName = [];
//   var date = DateTime.timestamp();
//   OutletModel? _outletModel;
//   _SelectOutletsState(Data? data);
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
//                 _isChecked =
//                     List<bool>.filled(_outletModel!.data!.length, false);
//               })
//             });
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
//         child: Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Text("Select Outlets"),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * .75,
//           child: ListView.builder(
//               physics: const ScrollPhysics(),
//               itemCount: lengthlist,
//               shrinkWrap: true,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.all(0),
//                           child: CheckboxListTile(
//                             title: SizedBox(
//                                 width: MediaQuery.of(context).size.width * .8,
//                                 child: Text(
//                                   "[${_outletModel!.data![index].store![0].storeCode}] ${_outletModel!.data![index].store![0].storeName}",
//                                   style: const TextStyle(fontSize: 13),
//                                 )),
//                             value: _isChecked![index],
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _isChecked![index] = newValue!;
//                                 name.add(_outletModel!.data![index].outletId
//                                     .toString());
//                                 storeName.add(_outletModel!
//                                     .data![index].store![0].storeName
//                                     .toString());
//                                 print("Store Names : $storeName");
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity
//                                 .leading, //  <-- leading Checkbox
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 // merch=_data!.data![index].firstName.toString();
//                 //Provider.of<AppProvider>(context, listen: false).setToken(userid);
//                 Preference.setOutlets(name);
//                 Preference.setStores(storeName);
//               });
//               Navigator.pop(context);
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => JourneyManager()));
//             },
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.0),
//                   child: Text("Save"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class SelectUnschOutlets extends StatefulWidget {
//   Data? data;

//   SelectUnschOutlets({super.key});
//   @override
//   State<SelectUnschOutlets> createState() => _SelectUnschOutletsState(data);
// }

// class _SelectUnschOutletsState extends State<SelectUnschOutlets> {
//   int i = 0;
//   Data? data;
//   int lengthlist = 0;
//   var myList = [];
//   List<String> name = [];
//   List<String> storeName = [];
//   var date = DateTime.timestamp();
//   OutletModel? _outletModel;
//   _SelectUnschOutletsState(Data? data);
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
//                 _isChecked =
//                     List<bool>.filled(_outletModel!.data!.length, false);
//               })
//             });
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
//         child: Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Text("Select Unscheduled Outlets"),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * .75,
//           child: ListView.builder(
//               physics: const ScrollPhysics(),
//               itemCount: lengthlist,
//               shrinkWrap: true,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.all(0),
//                           child: CheckboxListTile(
//                             title: SizedBox(
//                                 width: MediaQuery.of(context).size.width * .8,
//                                 child: Text(
//                                   "[${_outletModel!.data![index].store![0].storeCode}] ${_outletModel!.data![index].store![0].storeName}",
//                                   style: const TextStyle(fontSize: 13),
//                                 )),
//                             value: _isChecked![index],
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _isChecked![index] = newValue!;
//                                 name.add(_outletModel!.data![index].outletId
//                                     .toString());
//                                 storeName.add(_outletModel!
//                                     .data![index].store![0].storeName
//                                     .toString());
//                                 print("Unscheduled Store Names : $storeName");
//                                 Preference.setUnschOutlets(name);
//                                 Preference.setUnschStores(storeName);
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity
//                                 .leading, //  <-- leading Checkbox
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 // merch=_data!.data![index].firstName.toString();
//                 //Provider.of<AppProvider>(context, listen: false).setToken(userid);
//                 Preference.setUnschOutlets(name);
//                 Preference.setUnschStores(storeName);
//               });
//               Navigator.pop(context);
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => JourneyManager()));
//             },
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.0),
//                   child: Text("Save"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/Employee/Preference.dart';

import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/JourneyManager.dart';
import 'package:rms/NetworkModelfm/Outlet_model.dart';

class SelectOutlets extends StatefulWidget {
  Data? data;
  String j="";
  SelectOutlets(this.j);
  @override
  State<SelectOutlets> createState() => _SelectOutletsState(this.data,this.j);
}

class _SelectOutletsState extends State<SelectOutlets> {
  int i = 0;
  String j="";
  Data? data;
  int lengthlist = 0;
  var myList = [];
  List<String> name = [];
  List<String> storeName = [];
  var date = DateTime.timestamp();
  OutletModel? _outletModel;
  _SelectOutletsState(Data? data,this.j);
  _gettodayplanned() {
    ApiServices.service
        .outlet(
          context,
        )
        .then((value) => {
              setState(() {
                _outletModel = value;
                myList.addAll(_outletModel!.data!);
                lengthlist = myList.length;
                _isChecked =
                    List<bool>.filled(_outletModel!.data!.length, false);
              })
            });
  }

  List<bool>? _isChecked;
  @override
  initState() {
    super.initState();
    _gettodayplanned();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Select Outlets"),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .75,
          child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: lengthlist,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: CheckboxListTile(
                            title: Container(
                                width: MediaQuery.of(context).size.width * .8,
                                child: Text(
                                  "[" +
                                      _outletModel!
                                          .data![index].store![0].storeCode
                                          .toString() +
                                      "] " +
                                      _outletModel!
                                          .data![index].store![0].storeName
                                          .toString(),
                                  style: TextStyle(fontSize: 13),
                                )),
                            value: _isChecked![index],
                            onChanged: (newValue) {
                              setState(() {
                                _isChecked![index] = newValue!;
                                name.add(_outletModel!.data![index].outletId
                                    .toString());
                                storeName.add(_outletModel!
                                    .data![index].store![0].storeName
                                    .toString());
                                print("Store Names : $storeName");
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                // merch=_data!.data![index].firstName.toString();
                //Provider.of<AppProvider>(context, listen: false).setToken(userid);
                j=="0"?Preference.setOutlets(name):j=="2"?Preference.setOutlets1(name):Preference.setOutlets(name);
                j=="0"?Preference.setStores(storeName):j=="2"?Preference.setStores1(storeName):Preference.setStores(storeName);
              });
              Navigator.pop(context);
              j=="0"?Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => JourneyManager("1"))):Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => JourneyManager("2")));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
