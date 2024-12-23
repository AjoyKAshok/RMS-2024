import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/FieldManager/AddRelieverPage.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Relieverdetail_model.dart';

import '../Employee/version.dart';


class RelieverPage extends StatefulWidget {
  Data? data;
  @override
  State<RelieverPage> createState() => _RelieverPageState(this.data);
}

class _RelieverPageState extends State<RelieverPage> {
  int i=0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  String userName="";
  String emp="";
  var date= DateTime.timestamp();
  RelieverdetailModel? _data;
  _RelieverPageState(Data? data);
  _gettodayplanned() async{
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    ApiServices.service.relieverdetail(context,).then((value) => {
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
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(Duration(seconds: 1));
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
        backgroundColor: Color(0xfff5e1d5),
        foregroundColor:  Color(0XFFE84201),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reliever Details"),
            userName.isNotEmpty
                ? Text(
              userName+"("+emp+") - v "+AppVersion.version,
              style: TextStyle(fontSize: 9, color: Colors.black),
            )
                : Text(""),
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
                  height: 60,
                  width: MediaQuery.of(context).size.width*.94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color:  Color(0xfff5e1d5),
                  ),
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Outlet Name',
                      hintStyle: TextStyle(color:Color(0XFFE84201),),
                      border:InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Color(0XFFE84201),size: 30,),
                      suffixIcon: Icon(Icons.clear,color: Color(0XFFE84201),size: 25,),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: lengthlist,
                    shrinkWrap: true,
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
                                _data!.data![index].employee==null?Text(""):Text(_data!.data![index].employee!.firstName.toString()+"("+_data!.data![index].employee!.employeeId.toString()+")",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),
                                SizedBox(height: 2,),
                                Text("Reliever Employee : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                                SizedBox(height: 2,),
                                Text("From : "+_data!.data![index].fromDate.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
                                SizedBox(height: 2,),
                                Text("To : "+_data!.data![index].toDate.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
                                SizedBox(height: 2,),
                                Text("Reason : "+_data!.data![index].reason.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),),
                                //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height : 40,
        width: MediaQuery.of(context).size.width*.1,
        child: FloatingActionButton(
          backgroundColor: Color(0xfff5e1d5),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddRelieverPage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}