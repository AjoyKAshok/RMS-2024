import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/FieldManager/ReportsDetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../Employee/version.dart';
import '../NetworkModelfm/Report_model.dart';
import 'ApiService.dart';

class ReportsPage extends StatefulWidget {
  Data? data;

  ReportsPage({super.key});
  @override
  State<ReportsPage> createState() => _ReportsPageState(data);
}

class _ReportsPageState extends State<ReportsPage> {
  int i = 0;
  int j = 0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  String userName = "";
  String emp = "";
  var date = DateTime.timestamp();
  final TextEditingController _searchController = TextEditingController();
  ReportModel? _filteredDataNew;
  ReportModel? _dataNew;
  ReportModel? _data;
  var filteredList = [];
  List<String> searchList = [];
  List<String> searchListNew = [];
  var newFilteredList = [];
  List storeNames = [];
  var stores = [];
  var filteredStores = [];
  List<Map<String, dynamic>> customList = [];
  Map<String, dynamic>? currentStore;
  Duration difference = Duration();
  // DateTime? startDay;
  // DateTime? endDay;
  bool searchStarted = true;
  bool queryStarted = false;
  _ReportsPageState(Data? data);

  String calculateDifference(String? startDay, String? endDay) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime1 = format.parse(startDay!);
    DateTime dateTime2 = format.parse(endDay!);

    setState(() {
      difference = dateTime2.difference(dateTime1);
    });

    return difference.toString();
  }

  _gettodayplanned() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    ApiServices.service.report(context).then((value) => {
          setState(() {
            _data = value;
            myList.addAll(_data!.data!);

            lengthlist = myList.length;
            filteredStores = myList;
            for (int i = 0; i < lengthlist; i++) {
              filteredList.add(_data!.data![i].storeName.toString());

              currentStore = {
                'store_name': _data!.data![i].storeName.toString(),
                'date': _data!.data![i].date,
                'checkin_type': _data!.data![i].checkinType,
                'checkin_time': _data!.data![i].checkInTimestamp,
                'checkout_time': _data!.data![i].checkOutTimestamp,
                'employee_id': _data!.data![i].employeeId,
                'first_name': _data!.data![i].firstName,
                'checkin_location': _data!.data![i].checkinLocation,
                'checkout_location': _data!.data![i].checkoutLocation,
                'id': _data!.data![i].id.toString(),
                'outlet_id': _data!.data![i].outletId.toString(),
                'store_code': _data!.data![i].storeCode,
                // 'time_in_store': calculateDifference(
                //     _data!.data![i].checkInTimestamp,
                //     _data!.data![i].checkOutTimestamp)
              };
              customList.add(currentStore!);
            }
          }),
          print("Data Values : $customList"),
          print("Filtered Items Value : $filteredList")
        });
  }

  void _filterStores() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredStores = customList.where((store) {
        return store['store_name'].toLowerCase().contains(query);
      }).toList();
    });
    print("The List of Filtered Stores : $filteredStores");
  }

  // void filterSearchResults(String query) {
  //   if (query.isNotEmpty) {
  //     for (var item in filteredList) {
  //       if (item.toLowerCase().contains(query.toLowerCase())) {
  //         setState(() {
  //           searchList.add(item);
  //         });
  //       }
  //     }
  //     setState(() {
  //       filteredList.clear();
  //       filteredList.addAll(searchList);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       filteredList.clear();
  //       for (int i = 0; i < lengthlist; i++) {
  //         filteredList.add(_data!.data![i].storeName.toString());
  //       }
  //     });
  //   }
  // }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 6));
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
    _gettodayplanned();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Reports"),
            userName.isNotEmpty
                ? Text(
                    "$userName - ($emp) - v ${AppVersion.version}",
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
      ),
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
                  child: TextField(
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
                      hintText: 'Search by Outlet Name',
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
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    ReportsDetailPage(
                                                      filteredStores[index]
                                                              ['store_name']
                                                          .toString(),
                                                      filteredStores[index]
                                                          ['date'],
                                                      filteredStores[index]
                                                          ['checkin_type'],
                                                      filteredStores[index]
                                                          ['checkin_time'],
                                                      filteredStores[index]
                                                          ['checkout_time'],
                                                      filteredStores[index]
                                                          ['first_name'],
                                                      filteredStores[index]
                                                          ['checkin_location'],
                                                      filteredStores[index]
                                                          ['checkout_location'],
                                                      filteredStores[index]
                                                              ['id']
                                                          .toString(),
                                                      filteredStores[index]
                                                          ['employee_id'],
                                                      filteredStores[index]
                                                              ['outlet_id']
                                                          .toString(),
                                                    )),
                                              ),
                                            );
                                          },
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
                                                    filteredStores[index]
                                                            ['store_name']
                                                        .toString(),
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
                                                    "Date : ${filteredStores[index]['date']}",
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
                                                    "CheckIn Time : ${filteredStores[index]['checkin_time']}",
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "CheckOut Time : ${filteredStores[index]['checkout_time']}",
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Visited By : ${filteredStores[index]['first_name']} - ${filteredStores[index]['employee_id']}",
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
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              ReportsDetailPage(
                                                _data!.data![index].storeName
                                                    .toString(),
                                                _data!.data![index].date,
                                                _data!.data![index].checkinType,
                                                _data!.data![index]
                                                    .checkInTimestamp,
                                                _data!.data![index]
                                                    .checkOutTimestamp,
                                                _data!.data![index].firstName,
                                                _data!.data![index]
                                                    .checkinLocation,
                                                _data!.data![index]
                                                    .checkoutLocation,
                                                _data!.data![index].id
                                                    .toString(),
                                                _data!.data![index].employeeId,
                                                _data!.data![index].outletId
                                                    .toString(),
                                              )),
                                        ),
                                      );
                                    },
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
                                              _data!.data![index].storeName
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Date : ${_data!.data![index].date}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                           
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "CheckIn Time : ${_data!.data![index].checkInTimestamp}",
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "CheckOut Time : ${_data!.data![index].checkOutTimestamp}",
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Visited By : ${_data!.data![index].firstName} - ${_data!.data![index].employeeId}",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
