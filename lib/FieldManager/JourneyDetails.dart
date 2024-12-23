import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModel/WeekplannedJourney_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employee/version.dart';

class JourneyDetails extends StatefulWidget {
  Data? data;
  String emp = "";
  String name = "";
  JourneyDetails(this.emp, this.name, {super.key});
  @override
  State<JourneyDetails> createState() => _JourneyDetailsState(data, emp, name);
}

class _JourneyDetailsState extends State<JourneyDetails> {
  int i = 0;
  Data? data;
  String day = "";
  int lengthlist = 0;
  String emp = "";
  String name = "";
  String userName = "";
  String emp1 = "";
  var myList = [];
  WeekplannedJourneyModel? _data;
  _JourneyDetailsState(Data? data, this.emp, this.name);
  _gettodayplanned() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp1 = prefs1.get("id").toString();
    await ApiServices.service.weekjourny(context, emp).then((value) => {
          setState(() {
            myList.clear();
            _data = value;
            myList.addAll(_data!.data!);
            lengthlist = myList.length;
            print("My List : ${_data!.data![1].date}");
          })
        });
  }

  @override
  initState() {
    super.initState();
    _gettodayplanned();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: const Color(0xfff5e1d5),
          foregroundColor: const Color(0XFFE84201),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Journey Plan Details"),
                  userName.isNotEmpty
                      ? Text(
                          "$userName($emp1) - v ${AppVersion.version}",
                          style:
                              const TextStyle(fontSize: 9, color: Colors.black),
                        )
                      : const Text(""),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .19,
                height: 40,
                child: Card(
                    elevation: 0,
                    color: const Color(0XFFE84201),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                    ),
                    child: const Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 20, color: Colors.white),
                        Text(
                          "Map",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))),
              ),
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
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height*.9,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        // height : MediaQuery.of(context).size.height*.9,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * .9,
                              child: Card(
                                  elevation: 0,
                                  color: const Color(0xfff5e1d5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), //<-- SEE HERE
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            name,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text("Merchandiser ID : $emp"),
                                        ]),
                                  )),
                            ),
                            Container(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 1 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .pinkAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Sunday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 1
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 1
                                          ? Container(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Sunday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.6),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 2 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .greenAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Monday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 2
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 2
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));
                                                    return day == "Monday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.6),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                    15,
                                                                                width:
                                                                                    15,
                                                                                color:
                                                                                    Colors.greenAccent,
                                                                                child:
                                                                                    const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          const SizedBox(
                                                                            width:
                                                                                6,
                                                                          ),
                                                                          Text(
                                                                            _data!.data![index].contactNumber.toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                          ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                              icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 3 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Tuesday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 3
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 3
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Tuesday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.6),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 4 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .yellowAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Wednesday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 4
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 4
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Wednesday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.6),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 5 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .pinkAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Thursday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 5
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 5
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Thursday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      _data!.data![index].outlet ==
                                                                              null
                                                                          ? const Text(
                                                                              "")
                                                                          : Text(
                                                                              "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                              style: TextStyle(color: Colors.black.withOpacity(.6), fontWeight: FontWeight.w400, fontSize: 14),
                                                                            ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 6 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .greenAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Friday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 6
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 6
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Friday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      _data!.data![index].outlet ==
                                                                              null
                                                                          ? const Text(
                                                                              "")
                                                                          : Text(
                                                                              "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                              style: TextStyle(color: Colors.black.withOpacity(.6), fontWeight: FontWeight.w400, fontSize: 14),
                                                                            ),
                                                                      const SizedBox(
                                                                        height:
                                                                            25,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      // NEW SATURDAY
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     setState(() {
                                      //       i == 0 ? i = 7 : i = 0;
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //       width: MediaQuery.of(context)
                                      //           .size
                                      //           .width,
                                      //       height: 50,
                                      //       child: Card(
                                      //           color: Colors.white,
                                      //           shape: RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.only(
                                      //                       topRight:
                                      //                           Radius.circular(
                                      //                               5),
                                      //                       bottomRight:
                                      //                           Radius.circular(
                                      //                               5),
                                      //                       topLeft:
                                      //                           Radius.circular(
                                      //                               5),
                                      //                       bottomLeft:
                                      //                           Radius.circular(
                                      //                               5))),
                                      //           child: Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment
                                      //                     .spaceBetween,
                                      //             children: [
                                      //               Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .start,
                                      //                 children: [
                                      //                   ClipRRect(
                                      //                     borderRadius:
                                      //                         BorderRadius.only(
                                      //                             topLeft: Radius
                                      //                                 .circular(
                                      //                                     5),
                                      //                             bottomLeft: Radius
                                      //                                 .circular(
                                      //                                     5)),
                                      //                     child: Container(
                                      //                       width: 5,
                                      //                       height: 50,
                                      //                       color: Colors
                                      //                           .blueAccent,
                                      //                     ),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     width: 25,
                                      //                   ),
                                      //                   Icon(Icons
                                      //                       .light_mode_outlined),
                                      //                   SizedBox(
                                      //                     width: 20,
                                      //                   ),
                                      //                   Text("Saturday"),
                                      //                 ],
                                      //               ),
                                      //               Row(
                                      //                 children: [
                                      //                   i == 7
                                      //                       ? Icon(
                                      //                           Icons
                                      //                               .arrow_drop_up_sharp,
                                      //                           color: Color(
                                      //                               0XFFE84201),
                                      //                           size: 25,
                                      //                         )
                                      //                       : Icon(
                                      //                           Icons
                                      //                               .arrow_drop_down_sharp,
                                      //                           color: Color(
                                      //                               0XFFE84201),
                                      //                           size: 25,
                                      //                         ),
                                      //                   SizedBox(
                                      //                     width: 13,
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ],
                                      //           ))),
                                      // ),
                                      // i == 7
                                      //     ? Container(
                                      //         child: ListView.builder(
                                      //             physics:
                                      //                 NeverScrollableScrollPhysics(),
                                      //             shrinkWrap: true,
                                      //             itemCount: lengthlist,
                                      //             itemBuilder:
                                      //                 (BuildContext context,
                                      //                     int index) {
                                      //               day = DateFormat('EEEE')
                                      //                   .format(DateTime.parse(
                                      //                       _data!.data![index]
                                      //                           .date
                                      //                           .toString()));

                                      //               /// e.g Thursday
                                      //               return day == "Saturday"
                                      //                   ? GestureDetector(
                                      //                       onTap: () {

                                      //                       },
                                      //                       child: Padding(
                                      //                         padding:
                                      //                             const EdgeInsets
                                      //                                 .only(
                                      //                                 top: 6.0),
                                      //                         child: Card(
                                      //                           elevation: 0,
                                      //                           color: Colors
                                      //                               .white,
                                      //                           shape:
                                      //                               RoundedRectangleBorder(
                                      //                             borderRadius:
                                      //                                 BorderRadius
                                      //                                     .circular(
                                      //                                         8.0), //<-- SEE HERE
                                      //                           ),
                                      //                           child: Padding(
                                      //                             padding:
                                      //                                 const EdgeInsets
                                      //                                     .all(
                                      //                                     8.0),
                                      //                             child: Column(
                                      //                               crossAxisAlignment:
                                      //                                   CrossAxisAlignment
                                      //                                       .start,
                                      //                               children: [
                                      //                                 Text(
                                      //                                   _data!.data![index].storeCode.toString() +
                                      //                                       _data!.data![index].storeName.toString(),
                                      //                                   style: TextStyle(
                                      //                                       color:
                                      //                                           Colors.black,
                                      //                                       fontWeight: FontWeight.w800,
                                      //                                       fontSize: 14),
                                      //                                 ),
                                      //                                 _data!.data![index].outlet ==
                                      //                                         null
                                      //                                     ? Text(
                                      //                                         "")
                                      //                                     : Text(
                                      //                                         _data!.data![index].outlet!.outletArea.toString() + "  " + _data!.data![index].outlet!.outletCity.toString() + "  " + _data!.data![index].outlet!.outletCountry.toString(),
                                      //                                         style: TextStyle(color: Colors.black.withOpacity(.6), fontWeight: FontWeight.w400, fontSize: 14),
                                      //                                       ),
                                      //                                 SizedBox(
                                      //                                   height:
                                      //                                       25,
                                      //                                 ),
                                      //                                 Row(
                                      //                                   children: [
                                      //                                     Container(
                                      //                                       height:
                                      //                                           15,
                                      //                                       width:
                                      //                                           15,
                                      //                                       color:
                                      //                                           Colors.greenAccent,
                                      //                                       child:
                                      //                                           Center(
                                      //                                         child: Icon(
                                      //                                           Icons.phone,
                                      //                                           size: 12,
                                      //                                           color: Colors.white,
                                      //                                         ),
                                      //                                       ),
                                      //                                     ),
                                      //                                     SizedBox(
                                      //                                       width:
                                      //                                           6,
                                      //                                     ),
                                      //                                     Text(
                                      //                                       _data!.data![index].contactNumber.toString(),
                                      //                                       style:
                                      //                                           TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                      //                                     ),
                                      //                                     SizedBox(
                                      //                                       width:
                                      //                                           45,
                                      //                                     ),
                                      //                                     Container(
                                      //                                       height:
                                      //                                           15,
                                      //                                       width:
                                      //                                           15,
                                      //                                       color:
                                      //                                           Colors.blue,
                                      //                                       child:
                                      //                                           Center(
                                      //                                         child: Icon(
                                      //                                           Icons.location_on,
                                      //                                           size: 12,
                                      //                                           color: Colors.white,
                                      //                                         ),
                                      //                                       ),
                                      //                                     ),
                                      //                                     SizedBox(
                                      //                                       width:
                                      //                                           6,
                                      //                                     ),
                                      //                                     Text(
                                      //                                       "2798.98",
                                      //                                       style:
                                      //                                           TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                      //                                     ),
                                      //                                   ],
                                      //                                 ),
                                      //                               ],
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                       ),
                                      //                     )
                                      //                   : Container();
                                      //             }),
                                      //       )
                                      //     : Container(),
                                      // SizedBox(
                                      //   height: 13,
                                      // ),
                                      // OLD SATURDAY
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i == 0 ? i = 7 : i = 0;
                                          });
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Card(
                                                color: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            width: 5,
                                                            height: 50,
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        const Icon(Icons
                                                            .light_mode_outlined),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        const Text("Saturday"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        i == 7
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                                color: Color(
                                                                    0XFFE84201),
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 13,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      i == 7
                                          ? Container(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: lengthlist,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    day = DateFormat('EEEE')
                                                        .format(DateTime.parse(
                                                            _data!.data![index]
                                                                .date
                                                                .toString()));

                                                    /// e.g Thursday
                                                    return day == "Saturday"
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 6.0),
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0), //<-- SEE HERE
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _data!.data![index].storeCode.toString() +
                                                                            _data!.data![index].storeName.toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.6),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height:
                                                                                15,
                                                                                width:
                                                                                15,
                                                                                color:
                                                                                Colors.greenAccent,
                                                                                child:
                                                                                const Center(
                                                                                  child: Icon(
                                                                                    Icons.phone,
                                                                                    size: 12,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width:
                                                                                6,
                                                                              ),
                                                                              Text(
                                                                                _data!.data![index].contactNumber.toString(),
                                                                                style:
                                                                                TextStyle(color: Colors.black.withOpacity(.6), fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete,size: 20,),
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    //title: Text("Popup"),
                                                                                    content: Text("Do you want to delete?"),
                                                                                    actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text("Close"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: Text("Ok"),
                                                                                        onPressed: () {
                                                                                          var response = ApiServices.service.deletejourney(context, _data!.data![index].id.toString()
                                                                                          );
                                                                                          response.then((value) => {Navigator.of(context).pop(),_gettodayplanned()});
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ))));
  }
}
