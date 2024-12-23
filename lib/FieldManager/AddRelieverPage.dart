import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/FieldManager/Selectmerchandiser.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../Employee/version.dart';

class AddRelieverPage extends StatefulWidget {
  Data? data;
  @override
  State<AddRelieverPage> createState() => _AddRelieverPageState(/*this.data*/);
}

class _AddRelieverPageState extends State<AddRelieverPage> {
  int i=0;
  Data? data;
  SearchModel? _data;
  String merch="Select Merchandiser";
  int lengthlist = 0;
  var myList = [];
  String _selectedDate = '';
  String val = '';
  String val1 = '';
  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String  userName="";
  String emp="";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  var date= DateTime.timestamp();
  _refresh() async{
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      merch=prefs1.get("merch").toString();
   //   SharedPreferences prefs1 = await SharedPreferences.getInstance();
      userName = prefs1.get("user").toString();
      emp = prefs1.get("id").toString();
    });
  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  void _onSelectionChanged1(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  @override
  initState() {
    super.initState();
    _refresh();
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
              Text("Add Reliever"),
              userName!.isNotEmpty
                  ? Text(
                "$userName - ($emp) - v"+AppVersion.version,
                style: const TextStyle(fontSize: 9, color: Colors.black),
              )
                  : const Text(""),
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
                  child: Form(
                    key: _formKey,
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
                                    height : MediaQuery.of(context).size.height*.65,
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
                                                    GestureDetector(
                                                      onTap:()async{
                                                        SharedPreferences prefs1 = await SharedPreferences.getInstance();
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: true, // user must tap button!
                                                          builder: (BuildContext context) {
                                                            return Container(
                                                              height : MediaQuery.of(context).size.height*.83,
                                                              child: Dialog(
                                                                child:  SingleChildScrollView(
                                                                  child: SelectMerchandiser("1"),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        setState(() {
                                                          merch=prefs1.get("merch").toString();
                                                        });
                                                      },
                                                      child: Container(
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
                                                                Text(merch==""?"Select Merchandiser":merch,style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                                                Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    GestureDetector(
                                                      onTap:(){
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: true, // user must tap button!
                                                          builder: (BuildContext context) {
                                                            return Container(
                                                              height : 340,
                                                              width : MediaQuery.of(context).size.width*.7,
                                                              child: Dialog(
                                                                child:   Container(
                                                                  color: Colors.white,
                                                                  height: 340,
                                                                  child:  Column(
                                                                    children: [
                                                                      SfDateRangePicker(
                                                                        view: DateRangePickerView.month,
                                                                        allowViewNavigation: false,
                                                                        onSelectionChanged: _onSelectionChanged,
                                                                        selectionMode: DateRangePickerSelectionMode.single,
                                                                        backgroundColor: Colors.black12,
                                                                        headerHeight: 60,
                                                                        selectionColor: Color(0XFFE84201),
                                                                        headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.white),textAlign: TextAlign.center,backgroundColor: Color(0XFFE84201), ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: (){ Navigator.pop(context);},
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text("Ok    "),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
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
                                                                Text("Select Date",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(_selectedDate==""?"":_selectedDate.substring(0,10).toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
                                                                SizedBox(width: 5,),
                                                                Icon(Icons.calendar_month,size: 20,color: Colors.black,),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    GestureDetector(
                                                      onTap:(){
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: true, // user must tap button!
                                                          builder: (BuildContext context) {
                                                            return Container(
                                                              height : 340,
                                                              width : MediaQuery.of(context).size.width*.7,
                                                              child: Dialog(
                                                                child:   Container(
                                                                  color: Colors.white,
                                                                  height: 340,
                                                                  child:  Column(
                                                                    children: [
                                                                      SfDateRangePicker(
                                                                        view: DateRangePickerView.month,
                                                                        allowViewNavigation: false,
                                                                        onSelectionChanged: _onSelectionChanged1,
                                                                        selectionMode: DateRangePickerSelectionMode.single,
                                                                        backgroundColor: Colors.black12,
                                                                        headerHeight: 60,
                                                                        selectionColor: Color(0XFFE84201),
                                                                        headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.white),textAlign: TextAlign.center,backgroundColor: Color(0XFFE84201), ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: (){ Navigator.pop(context);},
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text("Ok    "),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
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
                                                                Text("Select Date",style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(_selectedDate1==""?"":_selectedDate1.substring(0,10).toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
                                                                SizedBox(width: 5,),
                                                                Icon(Icons.calendar_month,size: 20,color: Colors.black,),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap:(){
                                                            var response = ApiServices.service
                                                                .searchreliver(
                                                                context,merch,_selectedDate.substring(0,10).toString(),_selectedDate1.substring(0,10).toString());
                                                            response.then((value) => {
                                                              setState(() {
                                                                val=value.toString();
                                                              }),
                                                            _data = value,
                                                             myList.addAll(_data!.data!),
                                                            lengthlist = myList.length,
                                                            });
                                                          },
                                                          child: Container(
                                                            width : MediaQuery.of(context).size.width*.3,
                                                            height:40,
                                                            child: Card(
                                                                elevation: 0,
                                                                color: Color(0XFFE84201),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                                                                ),
                                                                child: Center(child: Text("Search Reliever",style: TextStyle(color: Colors.white),))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15,),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: true, // user must tap button!
                                                          builder: (BuildContext context) {
                                                            return Container(
                                                              height : MediaQuery.of(context).size.height*.83,
                                                              child: Dialog(
                                                                child:  SingleChildScrollView(
                                                                  child: Container(
                                                                      child: Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(12.0),
                                                                            child: Text("Select Reliever Merchandiser"),
                                                                          ),
                                                                          ListView.builder(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: lengthlist,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.all(12.0),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap:(){
                                                                                          setState(() {
                                                                                            val=_data!.data![index].firstName.toString();
                                                                                            val1=_data!.data![index].employeeId.toString();
                                                                                            Navigator.pop(context);
                                                                                          });
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(5.0),
                                                                                          child: Text(_data!.data![index].firstName.toString()),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }
                                                                          ),
                                                                        ],
                                                                      )
                                                                  )
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
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
                                                                Text(val==""?"Select Reliever Merchandiser":val,style: TextStyle(color: Colors.black.withOpacity(.5),),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.arrow_drop_down_sharp,size: 30,color: Colors.black.withOpacity(.5),),
                                                                Icon(Icons.clear,size: 20,color: Colors.black.withOpacity(.5),),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    Container(
                                                      width : MediaQuery.of(context).size.width*.83,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border(bottom: BorderSide(width: .0001)),
                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                        color:  Colors.white,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              //SizedBox(height: 10,),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Container(
                                                                  width : MediaQuery.of(context).size.width*.7,
                                                                  height: 95,
                                                                  child: TextField(
                                                                    controller: _emailcontroller,
                                                                    maxLines: 3,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      hintText: 'Reason',
                                                                      hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400,fontSize: 14)
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
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
                                                        GestureDetector(
                                                          onTap:(){
                                                            var response = ApiServices.service
                                                                .addreliver(
                                                                context,merch,val1,_selectedDate.substring(0,10).toString(),_selectedDate1.substring(0,10).toString(),_emailcontroller.text.toString());
                                                            response.then((value) => {
                                                            Navigator.pop(context),
                                                            });
                                                          },
                                                          child: Container(
                                                            width : MediaQuery.of(context).size.width*.19,
                                                            height:40,
                                                            child: Card(
                                                                elevation: 0,
                                                                color: Color(0XFFE84201),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                                                                ),
                                                                child: Center(child: Text("Save",style: TextStyle(color: Colors.white),))),
                                                          ),
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
                          ),]),
                  ),)))
    );
  }
}