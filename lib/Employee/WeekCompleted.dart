import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/Employee/ApiService.dart';

import 'package:intl/intl.dart';
import 'package:rms/NetworkModel/VisitedJourney_Model.dart';

class WeekCompleted extends StatefulWidget {
  Data? data;
  @override
  State<WeekCompleted> createState() => _WeekCompletedState(this.data);
}

class _WeekCompletedState extends State<WeekCompleted> {
  int i=0;
  Data? data;
  String day="";
  int lengthlist = 0;
  var myList = [];
  VisitedJourneyModel? _data;
  _WeekCompletedState(Data? data);
  _gettodayplanned() {
    ApiService.service.visitJourney(context).then((value) => {
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
    return SingleChildScrollView(
      child: Container(
        child:Container(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=1:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Sunday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==1?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==1?Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Sunday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=2:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Monday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==2?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==2?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString()));
                        return day=="Monday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=3:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Tuesday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==3?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==3?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Tuesday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Icon(Icons.location_on,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text("2798.98",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=4:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Wednesday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==4?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==4?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Wednesday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Icon(Icons.location_on,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text("2798.98",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=5:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Thursday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==5?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==5?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Thursday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Icon(Icons.location_on,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text("2798.98",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=6:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Friday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==6?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==6?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Friday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Icon(Icons.location_on,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text("2798.98",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
                SizedBox(height: 13,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      i==0?i=7:i=0;
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                      width: 5,
                                      height: 50,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Icon(Icons.light_mode_outlined),
                                  SizedBox(width: 20,),
                                  Text("Saturday"),
                                ],
                              ),
                              Row(
                                children: [
                                  i==7?Icon(Icons.arrow_drop_up_sharp,color: Color(0XFFE84201),size: 25,):Icon(Icons.arrow_drop_down_sharp,color: Color(0XFFE84201),size: 25,),
                                  SizedBox(width: 13,),
                                ],
                              ),
                            ],
                          ))),
                ),
                i==7?Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lengthlist,
                      itemBuilder: (BuildContext context, int index) {
                        day= DateFormat('EEEE').format(DateTime.parse(_data!.data![index].date.toString())); /// e.g Thursday
                        return day=="Saturday"?GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
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
                                    Text(_data!.data![index].storeCode.toString()+_data!.data![index].storeName.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
                                    Text(_data!.data![index].outletArea.toString()+"  "+_data!.data![index].outletCity.toString()+"  "+_data!.data![index].outletCountry.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 14),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Icon(Icons.phone,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(_data!.data![index].contactNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                        SizedBox(width: 45,),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Icon(Icons.location_on,size: 12,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text("2798.98",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container();
                      }),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

