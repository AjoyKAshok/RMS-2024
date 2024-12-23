import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:rms/Employee/ApiService.dart';

import 'package:rms/NetworkModel/TimesheetDaily_Model.dart';


class TodayTimesheet extends StatefulWidget {
  Data? data;
  @override
  State<TodayTimesheet> createState() => _TodayTimesheetState(this.data);
}

class _TodayTimesheetState extends State<TodayTimesheet> {
  int i=0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var date= DateTime.timestamp();
  TimesheetDailyModel? _data;
  _TodayTimesheetState(Data? data);
  _gettodayplanned() {
    ApiService.service.dailytimesheet(context,date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString()).then((value) => {
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
                        Text("Outlet Name : "+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                        SizedBox(height: 5,),
                        Text("CheckIn Time : "+_data!.data![index].checkinTime.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                        SizedBox(height: 5,),
                        Text("CheckOut Time : "+_data!.data![index].checkoutTime.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                        //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}