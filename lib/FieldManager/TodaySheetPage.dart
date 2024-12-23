import 'package:flutter/material.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Timesheet_model.dart';

class TodaySheetPage extends StatefulWidget {
  Data? data;
  String emp = "";
  TodaySheetPage(this.emp, {super.key});
  @override
  State<TodaySheetPage> createState() => _TodaySheetPageState(data, emp);
}

class _TodaySheetPageState extends State<TodaySheetPage> {
  int i = 0;
  Data? data;
  String emp = "";
  int lengthlist = 0;
  var myList = [];
  var date = DateTime.timestamp();
  TimesheetModel? _data;
  _TodaySheetPageState(Data? data, this.emp);
  _gettodayplanned() {
    ApiServices.service
        .dailytimesheet(context, emp, "${date.year}-${date.month}-${date.day}")
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
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
    return Center(
        child: ListView.builder(
            itemCount: lengthlist,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Outlet Name : ${_data!.data![index].storeName}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "CheckIn Time : ${_data!.data![index].checkInTimestamp}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "CheckOut Time : ${_data!.data![index].checkOutTimestamp}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
