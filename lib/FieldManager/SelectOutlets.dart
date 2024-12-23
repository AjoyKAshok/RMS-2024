import 'package:flutter/material.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/JourneyManager.dart';
import 'package:rms/NetworkModelfm/Outlet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectOutlets extends StatefulWidget {
  Data? data;
  String j = "";
  SelectOutlets(this.j, {super.key});
  @override
  State<SelectOutlets> createState() => _SelectOutletsState(data, j);
}

class _SelectOutletsState extends State<SelectOutlets> {
  int i = 0;
  String j = "";
  Data? data;
  int lengthlist = 0;

  String emp = "Emp7325";
  var myList = [];
  var filteredList = [];
  var filteredList1 = [];
  final TextEditingController _sea = TextEditingController();
  List<String> id = [];
  List<String> name = [];
  List<String> storeName = [];
  Map<String, dynamic> theStore = {};
  List<Map<String, dynamic>> theSelectedStores = [];
  List<Map<String, dynamic>> theFilteredStores = [];
  List<Map<String, dynamic>> theAllStores = [];
  Set<String> outletIds = {};
  var date = DateTime.timestamp();
  OutletModel? _outletModel;
  _SelectOutletsState(Data? data, this.j);
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
                for (int i = 0; i < lengthlist; i++) {
                  filteredList.add(
                      "${_outletModel!.data![i].outletId} / ${_outletModel!.data![i].store![0].storeCode} / ${_outletModel!.data![i].store![0].storeName}");
                  theStore = {
                    "check_value": false,
                    "outlet_id": _outletModel!.data![i].outletId,
                    "store_code": _outletModel!.data![i].store![0].storeCode,
                    "store_name": _outletModel!.data![i].store![0].storeName,
                  };
                  theAllStores.add(theStore);
                }
                print("THe map of All store : $theAllStores");
              })
            });
  }

  // _getplanned() async {
  //   SharedPreferences prefs1 = await SharedPreferences.getInstance();
  //   userName = prefs1.get("user").toString();
  //   emp1 = prefs1.get("id").toString();
  //   print("The User Name is : $userName and Emp Id is : $emp1. The Merchandiser Emp Id is : $emp");
  //   await ApiServices.service.weekjourny(context, emp).then((value) => {
  //         setState(() {
  //           myList.clear();
  //           // _data = value;
  //           myList.addAll(value.data!);
  //           lengthlist = myList.length;
  //           print("My List : ${value.data![1].date}");

  //           for (var i = 0; i < lengthlist; i++) {
  //             print("The Weeks JP List : ${value.data![i].storeName}");
  //             theStore = {
  //               "outlet_id": value.data![i].outletId.toString(),
  //               "store_name": value.data![i].storeName,
  //               "store_code": value.data![i].storeCode,
  //             };
  //             stores.add(theStore!);
  //           }

  //           print("The List of Stores in the Week : $stores");

  //           for (var item in stores) {
  //             print("Item Details : $item");
  //             if (!outletIds.contains(item['outlet_id'])) {
  //               outletIds.add(item['outlet_id']);
  //               uniqueStores.add(item);
  //             }
  //           }
  //           print("The Unique List : $uniqueStores");
  //         })
  //       });
  // }

  void _filterItems(String query) {
    List<Map<String, dynamic>> results = [];
    if (query.isEmpty) {
      // results = filteredList;
      results = theAllStores;
      print("The empty filter : $results");
    } else {
      results = theAllStores
          .where(
            // (item) => item.toLowerCase().contains(query.toLowerCase())
            (item) =>
                item["store_code"]
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item["store_name"]
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      // filteredList1 = results;
      theFilteredStores = results;
    });
  }

  List<bool>? _isChecked;
  @override
  initState() {
    super.initState();
    _gettodayplanned();
    // _getplanned();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .90,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Select Outlets",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _sea,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _filterItems(value);
                        setState(() {
                          i = 1;
                        });
                      },
                    ),
                  ),
                  i == 0
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .68,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              itemCount: lengthlist,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: CheckboxListTile(
                                            title: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .8,
                                                child: Text(
                                                  "[${theAllStores[index]['store_code']}] -- ${theAllStores[index]['store_name']}",
                                                  // "[${_outletModel!.data![index].store![0].storeCode}] ${_outletModel!.data![index].store![0].storeName}",
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                )),
                                            value: theAllStores[index]
                                                ['check_value'],
                                            
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   // _isChecked![index]
                                              //   theAllStores[index]
                                              //       ['check_value'] = newValue!;
                                              //   id.add(theAllStores[index]
                                              //       ['store_code']);
                                              //   // id.add(_outletModel!
                                              //   //     .data![index]
                                              //   //     .store![0]
                                              //   //     .storeCode
                                              //   //     .toString());
                                              //   name.add(theAllStores[index]
                                              //           ['outlet_id']
                                              //       .toString());
                                              //   // name.add(_outletModel!
                                              //   //     .data![index].outletId
                                              //   //     .toString());
                                              //   storeName.add(
                                              //       theAllStores[index]
                                              //           ['store_name']);
                                              //   // storeName.add(_outletModel!
                                              //   //     .data![index]
                                              //   //     .store![0]
                                              //   //     .storeName
                                              //   //     .toString());
                                              //   print(
                                              //       "Store Names : $storeName");
                                              //   print("Store Codes : $id");
                                              //   print("Outlet Ids : $name");
                                              // });
                                              if (newValue == true) {
                                                setState(() {
                                                  
                                                  theAllStores[index]
                                                          ['check_value'] =
                                                      newValue!;
                                                  
                                                  id.add(
                                                      theAllStores[index]
                                                          ['store_code']);
                                                  
                                                  name.add(
                                                      theAllStores[index]
                                                              ['outlet_id']
                                                          .toString());
                                                  
                                                  storeName.add(
                                                      theAllStores[index]
                                                          ['store_name']);
                                                  print("Store Codes : $id");
                                                  print(" Names : $name");
                                                  print(
                                                      "Store Names : $storeName");
                                                  print(
                                                      "The value on click : $newValue");
                                                  print(
                                                      "The click value passed : ${theAllStores[index]['check_value']}");
                                                });
                                              } 
                                              else {
                                                setState(() {
                                                  theAllStores[index]
                                                          ['check_value'] =
                                                      newValue!;
                                                id.remove(
                                                    theAllStores[index]
                                                        ['store_code']);
                                                name.remove(
                                                    theAllStores[index]
                                                        ['outlet_id']);
                                                storeName.remove(
                                                    theAllStores[index]
                                                        ['store_name']);
                                                print("Store Codes from else : $id");
                                                  print(" Outlet Ids from else : $name");
                                                  print(
                                                      "Store Names from else : $storeName");
                                                  print(
                                                      "The value on click from else : $newValue");
                                                  print(
                                                      "The click value passed from else : ${theAllStores[index]['check_value']}");
                                                });
                                              }
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
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .68,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              itemCount: theFilteredStores.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: CheckboxListTile(
                                            title: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .8,
                                                child: Text(
                                                  "[${theFilteredStores[index]['store_code']}] -- ${theFilteredStores[index]['store_name']}",
                                                  // "${filteredList1[index].split(" / ")[1]} - ${filteredList1[index].split(" / ")[2]}",
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                )),
                                            value: theFilteredStores[index]
                                                ['check_value'],
                                            onChanged: (newValue) {
                                              print(
                                                      "The value on click : $newValue");
                                              if (newValue == true) {
                                                setState(() {
                                                 
                                                  theFilteredStores[index]
                                                          ['check_value'] =
                                                      newValue!;
                                                  
                                                  id.add(
                                                      theFilteredStores[index]
                                                          ['store_code']);
                                                  
                                                  name.add(
                                                      theFilteredStores[index]
                                                              ['outlet_id']
                                                          .toString());
                                                  
                                                  storeName.add(
                                                      theFilteredStores[index]
                                                          ['store_name']);
                                                  print("Store Codes : $id");
                                                  print(" Names : $name");
                                                  print(
                                                      "Store Names : $storeName");
                                                  print(
                                                      "The value on click : $newValue");
                                                  print(
                                                      "The click value passed : ${theFilteredStores[index]['check_value']}");
                                                });
                                              } 
                                              else {
                                                setState(() {
                                                  theFilteredStores[index]
                                                          ['check_value'] =
                                                      newValue!;
                                                id.remove(
                                                    theFilteredStores[index]
                                                        ['store_code']);
                                                name.remove(
                                                    theFilteredStores[index]
                                                        ['outlet_id']);
                                                storeName.remove(
                                                    theFilteredStores[index]
                                                        ['store_name']);
                                                print("Store Codes from else : $id");
                                                  print(" Outlet Ids from else : $name");
                                                  print(
                                                      "Store Names from else : $storeName");
                                                  print(
                                                      "The value on click from else : $newValue");
                                                  print(
                                                      "The click value passed from else : ${theFilteredStores[index]['check_value']}");
                                                });
                                              }
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
                ],
              ),
            )),
        Positioned(
          bottom: 0,
          right: 15,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // merch=_data!.data![index].firstName.toString();
                  //Provider.of<AppProvider>(context, listen: false).setToken(userid);

                  j == "0"
                      ? Preference.setOutlets(name)
                      : j == "2"
                          ? Preference.setOutlets1(name)
                          : Preference.setOutlets(name);
                  j == "0"
                      ? Preference.setStores(storeName)
                      : j == "2"
                          ? Preference.setStores1(storeName)
                          : Preference.setStores(storeName);
                });
                Navigator.pop(context);
                j == "0"
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => JourneyManager("1")))
                    : Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            JourneyManager("2")));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
