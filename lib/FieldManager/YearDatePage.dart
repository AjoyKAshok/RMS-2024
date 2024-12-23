import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModel/TimesheetMonthly_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class YearDatePage extends StatefulWidget {
  Data? data;
  String emp = "";
  YearDatePage(this.emp, {super.key});
  @override
  State<YearDatePage> createState() => _YearDatePageState(data, emp);
}

class _YearDatePageState extends State<YearDatePage> {
  int i = 0;
  int j = 0;
  String emp = "";
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var date = DateTime.timestamp();
  var date1 = DateTime.timestamp();
  DateTime today = DateTime.now();
  TimesheetMonthlyModel? _data;
  _YearDatePageState(Data? data, this.emp);
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        setState(() {
          j = 0;
        });
        _gettodayplanned1();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  _gettodayplanned1() {
    ApiServices.service
        .monthlytimesheet(
            context, _selectedDate.substring(0, 10).toString(), emp)
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    _selectedDate = today.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return i == 1
        ? Container(
            //height : MediaQuery.of(context).size.height*.5,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 205),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .77,
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: 31,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${DateFormat('MMMM').format(DateTime(0, int.parse(_selectedDate!.substring(5, 7))))} $index",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), //<-- SEE HERE
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .41,
                                                      child: const Text(
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                      child: const Text(
                                                          "Check in",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0XFFE84201),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                      child: const Text(
                                                          "Check out",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0XFFE84201),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(height: 5,),
                                                Container(
                                                  // height:300,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: lengthlist,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int inde) {
                                                        return (int.parse(_data!
                                                                    .data![inde]
                                                                    .date!
                                                                    .substring(
                                                                        8,
                                                                        10)) ==
                                                                index)
                                                            ? Column(
                                                                children: [
                                                                  const Divider(),
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .41,
                                                                        child:
                                                                            Text(
                                                                          _data!
                                                                              .data![inde]
                                                                              .storeName,
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .2,
                                                                        child: Text(
                                                                            _data!.data![inde].checkInTimestamp
                                                                                .toString(),
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .2,
                                                                        child: Text(
                                                                            _data!.data![inde].checkOutTimestamp
                                                                                .toString(),
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
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
                  j == 1
                      ? Positioned(
                          bottom: 200,
                          right: 30,
                          left: 30,
                          child: Container(
                            color: Colors.white,
                            height: 300,
                            child: SfDateRangePicker(
                              view: DateRangePickerView.year,
                              allowViewNavigation: false,
                              onSelectionChanged: _onSelectionChanged,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              backgroundColor: Colors.black12,
                              headerHeight: 80,
                              selectionColor: const Color(0XFFE84201),
                              headerStyle: const DateRangePickerHeaderStyle(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                                backgroundColor: Color(0XFFE84201),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(side: BorderSide.none),
                      onPressed: () {
                        setState(() {
                          j = 1;
                          myList = [];
                        });
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0XFFE84201),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * .57,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * .25,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(side: BorderSide.none),
                  onPressed: () {
                    setState(() {
                      i = 1;
                      j = 1;
                      myList = [];
                    });
                  },
                  child: const Icon(
                    Icons.calendar_today,
                    color: Color(0XFFE84201),
                  ),
                ),
              ),
            ],
          );
  }
}
