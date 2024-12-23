import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/TodayTimeSheet.dart';
import 'package:rms/Employee/YeartoDate.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/NetworkModel/TimesheetMonthly_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheet extends StatefulWidget {
  Data? data;

  TimeSheet({super.key});
  @override
  State<TimeSheet> createState() => _TimeSheetState(data);
}

class _TimeSheetState extends State<TimeSheet> {
  int i = 0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var date = DateTime.timestamp();
  var date1 = DateTime.timestamp();
  String emp = "";
  String user = "";
  String formattedDate = "";
  TimesheetMonthlyModel? _data;
  _TimeSheetState(Data? data);
  DateTime now = DateTime.now();
  _gettodayplanned() {
    ApiService.service
        .monthlytimesheet(context, "${date.year}-${date.month}-${date.day}")
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
              })
            });
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 1));
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
    formattedDate = DateFormat('MMM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          foregroundColor: Colors.black.withOpacity(.6),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TimeSheet",
                style: TextStyle(
                    color: Colors.black.withOpacity(.6),
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "$user($emp) - v "+AppVersion.version,
                style: TextStyle(
                    color: Colors.black.withOpacity(.6),
                    fontSize: 8,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Pattern.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 15),
                          ),
                          Text(
                            user,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Merchandiser Id",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 15),
                          ),
                          Text(
                            emp,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      color: Colors.white,
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        indicatorColor: const Color(0XFFE84201),
                        labelColor: const Color(0XFFE84201),
                        labelStyle: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabAlignment: TabAlignment.fill,
                        isScrollable: false,
                        tabs: [
                          const Tab(
                            text: "Year to Date",
                          ),
                          Container(
                            child: const Tab(
                              text: "Month to Date",
                            ),
                          ),
                          const Tab(
                            text: "Today",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        children: [
                          YeartoDate(),
                          Container(
                            //height : MediaQuery.of(context).size.height*.5,
                            color: Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 225),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: date.day + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return index == 0
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$formattedDate $index",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0), //<-- SEE HERE
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .41,
                                                                child:
                                                                    const Text(
                                                                  "Outlet",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFFE84201),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .2,
                                                                child: const Text(
                                                                    "Check in",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFE84201),
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .2,
                                                                child: const Text(
                                                                    "Check out",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFE84201),
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ),
                                                            ],
                                                          ),
                                                          //SizedBox(height: 5,),
                                                          Container(
                                                            // height:300,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount:
                                                                        lengthlist,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int inde) {
                                                                      return (int.parse(_data!.data![inde].date!.substring(8, 10)) ==
                                                                              index)
                                                                          ? Column(
                                                                              children: [
                                                                                const Divider(),
                                                                                Row(
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      width: 6,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width * .41,
                                                                                      child: Text(
                                                                                        _data!.data![inde].storeName,
                                                                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width * .2,
                                                                                      child: Text(_data!.data![inde].checkinTime.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width * .2,
                                                                                      child: Text(_data!.data![inde].checkoutTime.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : Container();
                                                                    }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                  }),
                            ),
                          ),
                          TodayTimesheet(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
