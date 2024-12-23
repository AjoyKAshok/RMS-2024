import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Outlet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class OutletPage extends StatefulWidget {
  Data? data;

  OutletPage({super.key});
  @override
  State<OutletPage> createState() => _OutletPageState(data);
}

class _OutletPageState extends State<OutletPage> {
  int i = 0;
  Data? data;
  int lengthlist = 0;
  String userName = "";
  String emp = "";
  var myList = [];
  bool searchStarted = true;
  bool queryStarted = false;
  final TextEditingController _searchController = TextEditingController();
  var filteredStores = [];
  List<Map<String, dynamic>> customList = [];
  Map<String, dynamic>? currentStore;
  var date = DateTime.timestamp();
  OutletModel? _outletModel;
  _OutletPageState(Data? data);
  _outlet() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    ApiServices.service
        .outlet(
          context,
        )
        .then((value) => {
              setState(() {
                _outletModel = value;
                myList.addAll(_outletModel!.data!);
                lengthlist = myList.length;
                for (int i = 0; i < lengthlist; i++) {
                  filteredStores.add(
                      '${_outletModel!.data![i].store![0].storeName} + ${_outletModel!.data![i].store![0].storeCode}');

                  currentStore = {
                    'store_name':
                        _outletModel!.data![i].store![0].storeName.toString(),
                    "store_address":
                        _outletModel!.data![i].store![0].address.toString(),
                    'latitude': _outletModel!.data![i].outletLat.toString(),
                    'longitude': _outletModel!.data![i].outletLong.toString(),
                    'contact_number': _outletModel!
                        .data![i].store![0].contactNumber
                        .toString(),
                    'location':
                        '${_outletModel!.data![i].outletArea},${_outletModel!.data![i].outletCity},${_outletModel!.data![i].outletState},${_outletModel!.data![i].outletCountry}',
                    'store_code':
                        _outletModel!.data![i].store![0].storeCode.toString(),
                    'filter_name':
                        '${_outletModel!.data![i].store![0].storeName} + ${_outletModel!.data![i].store![0].storeCode}',
                  };
                  customList.add(currentStore!);
                }
                log("Data Values : $customList");
                print("Filtered Items Value : $filteredStores");
              })
            });
  }

  void _filterStores() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredStores = customList.where((store) {
        return store['filter_name'].toLowerCase().contains(query);
      }).toList();
    });
    print("The List of Filtered Stores : $filteredStores");
  }

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
    _outlet();
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
            const Text("Outlet Details"),
            userName.isNotEmpty
                ? Text(
                    "$userName($emp) - v ${AppVersion.version}",
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
      ),
      // THE FOLLOWING FLOATING ACTION BUTTON IS TO ADD NEW OUTLETS BY FILED MANAGER THEMSELVES - NOT IMPLEMENTED YET.
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.orange[100],
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const AddOutletPage()),
      //     );
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.black,
      //   ),
      // ),
      // ABOVE FLOATING ACTION BUTTON TO BE ENABLED ONLY IF NECESSARY.
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
                  child: TextFormField(
                    controller: _searchController,
                    onTap: () {
                      setState(() {
                        searchStarted = true;
                      });
                    },
                    onChanged: (query) {
                      setState(() {
                        queryStarted = true;
                      });
                      _filterStores();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Outlet Name / Code',
                      hintStyle: const TextStyle(
                        color: Color(0XFFE84201),
                      ),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0XFFE84201),
                        size: 30,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            queryStarted = false;

                            _searchController.clear();
                            FocusScope.of(context).unfocus();
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .9,
                  child: searchStarted
                      ? queryStarted
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: filteredStores.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Card(
                                            elevation: 0,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8.0), //<-- SEE HERE
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '[${filteredStores[index]['store_code']}] - ${filteredStores[index]['store_name']}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    'Address : ${filteredStores[index]['store_address']}'
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Latitude : ${filteredStores[index]['latitude']}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Longitude : ${filteredStores[index]['longitude']}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Conatct Number : ${filteredStores[index]['contact_number']}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Location : ${filteredStores[index]['location']}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: lengthlist,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), //<-- SEE HERE
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '[${_outletModel!.data![index].store![0].storeCode}] - ${_outletModel!.data![index].store![0].storeName} ',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              _outletModel!.data![index]
                                                  .store![0].address
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Latitude : ${_outletModel!.data![index].outletLat}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Longitude : ${_outletModel!.data![index].outletLong}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Conatct Number : ${_outletModel!.data![index].store![0].contactNumber}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Location : ${_outletModel!.data![index].outletArea},${_outletModel!.data![index].outletCity},${_outletModel!.data![index].outletState},${_outletModel!.data![index].outletCountry}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                      : const SizedBox(),
                ),
                // ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: lengthlist,
                //     shrinkWrap: true,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 6.0),
                //         child: Card(
                //           elevation: 0,
                //           color: Colors.white,
                //           shape: RoundedRectangleBorder(
                //             borderRadius:
                //                 BorderRadius.circular(8.0), //<-- SEE HERE
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "[${_outletModel!.data![index].store![0].storeCode}]${_outletModel!.data![index].store![0].storeName}",
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w700,
                //                       fontSize: 15),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //                 Text(
                //                   _outletModel!.data![index].store![0].address
                //                       .toString(),
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 15),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //                 Text(
                //                   "Latitude : ${_outletModel!.data![index].outletLat}",
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //                 Text(
                //                   "Longitude : ${_outletModel!.data![index].outletLong}",
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //                 Text(
                //                   "Conatct Number : ${_outletModel!.data![index].store![0].contactNumber}",
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //                 Text(
                //                   "Location : ${_outletModel!.data![index].outletArea},${_outletModel!.data![index].outletCity},${_outletModel!.data![index].outletState},${_outletModel!.data![index].outletCountry}",
                //                   style: const TextStyle(
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 14),
                //                 ),
                //                 //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
