import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:rms/Employee/ApiService.dart';

import 'package:rms/NetworkModel/TimesheetDaily_Model.dart';


class AddWeekPage extends StatefulWidget {
  Data? data;
  @override
  State<AddWeekPage> createState() => _AddWeekPageState(/*this.data*/);
}

class _AddWeekPageState extends State<AddWeekPage> {
  int i=0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var date= DateTime.timestamp();
  String  userName="";
  String emp="";
/*  TimesheetDailyModel? _data;
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
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 3,
            backgroundColor: Color(0xfff5e1d5),
            foregroundColor:  Color(0XFFE84201),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Week Off"),
                Text("SALEESH BHAMDARI HIRA(RMS0081)-FM4-4-16",style: TextStyle(fontSize: 9,color: Colors.black),),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Pattern.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: MediaQuery.of(context).size.height*.9,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                            height : MediaQuery.of(context).size.height*.9,
                            child:  Column(
                              children: [
                                Container(
                                  height : MediaQuery.of(context).size.height*.45,
                                  width : MediaQuery.of(context).size.width*.9,
                                  child: Card(
                                    elevation: 0,
                                    color: Color(0xfff5e1d5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30,),
                                          Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width : MediaQuery.of(context).size.width*.83,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          border: Border(bottom: BorderSide(width: .0001)),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color:  Colors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Select Merchandiser",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,color: Color(0XFFE84201),),
                                                               // Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Container(
                                                        width : MediaQuery.of(context).size.width*.83,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          border: Border(bottom: BorderSide(width: .0001)),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color:  Colors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Select Outlets",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,color: Color(0XFFE84201),),
                                                               // Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Container(
                                                        width : MediaQuery.of(context).size.width*.83,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          border: Border(bottom: BorderSide(width: .0001)),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color:  Colors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Select Month",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,color: Color(0XFFE84201),),
                                                               // Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Container(
                                                        width : MediaQuery.of(context).size.width*.83,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          border: Border(bottom: BorderSide(width: .0001)),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color:  Colors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Select Days",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,color: Color(0XFFE84201),),
                                                                //Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width : MediaQuery.of(context).size.width*.19,
                                                            height:40,
                                                            child: Card(
                                                                elevation: 0,
                                                                color: Color(0XFFE84201),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                                                                ),
                                                                child: Center(child: Text("ADD",style: TextStyle(color: Colors.white),))),
                                                          ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),]
                                )
                          ),
                    ),
                  ],
                ),
              ),
            ),]),)))
        );
  }
}