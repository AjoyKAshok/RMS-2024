import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/FieldManager/AddRelieverPage.dart';
import 'package:rms/FieldManager/AddWeekPage.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/FieldManager/JourneyDetails.dart';
import 'package:rms/FieldManager/JourneyManager.dart';
import 'package:rms/NetworkModelfm/Merchandiser_model.dart';

class SelectMerchandiser extends StatefulWidget {
  Data? data;
  String j = "";
  SelectMerchandiser(this.j);
  @override
  State<SelectMerchandiser> createState() =>
      _SelectMerchandiserState(this.data, this.j);
}

class _SelectMerchandiserState extends State<SelectMerchandiser> {
  int i = 0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  var filteredList = [];
  var filteredList1 = [];
  var date = DateTime.timestamp();
  final TextEditingController _sea = TextEditingController();
  MerchandiserModel? _data;
  String j = "";
  _SelectMerchandiserState(Data? data, this.j);
  _gettodayplanned() {
    ApiServices.service
        .merchandiser(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
                for (int i = 0; i < lengthlist; i++) {
                  filteredList.add(_data!.data![i].employeeId.toString() +
                      " - " +
                      _data!.data![i].firstName.toString());
                }
              })
            });
  }

  void _filterItems(String query) {
    var results = [];
    if (query.isEmpty) {
      results = filteredList;
    } else {
      results = filteredList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredList1 = results;
    });
    print("Printing the filtered Merch : $filteredList1");
  }

  @override
  initState() {
    super.initState();
    _gettodayplanned();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Select Merchandiser"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _sea,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filterItems(value);
                setState(() {
                  i = 1;
                });
              },
            ),
          ),
          i == 0
              ? ListView.builder(
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
                            onTap: () {
                              setState(() {
                                // merch=_data!.data![index].firstName.toString();
                                String name =
                                    _data!.data![index].employeeId.toString();
                                String empName =
                                    _data!.data![index].firstName.toString();
                                //Provider.of<AppProvider>(context, listen: false).setToken(userid);
                                j == "0"
                                    ? Preference.setMerchandiser(name)
                                    : Preference.setMerchandiser1(name);
                                j == "0"
                                    ? Preference.setMerchandiserName(empName)
                                    : Preference.setMerchandiserName1(empName);
                                Navigator.pop(context);
                                j == "0"
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                JourneyManager("1")))
                                    : j == "2"
                                        ? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        JourneyManager("2")))
                                        : Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AddRelieverPage()));
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  _data!.data![index].employeeId.toString() +
                                      " - " +
                                      _data!.data![index].firstName.toString()),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredList1.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // merch=_data!.data![index].firstName.toString();
                                String name = filteredList1[index]
                                    .toString()
                                    .substring(0, 7);
                                String empName = filteredList1[index]
                                    .toString()
                                    .substring(10);
                                print(name);
                                print(empName);
                                //Provider.of<AppProvider>(context, listen: false).setToken(userid);
                                j == "0"
                                    ? Preference.setMerchandiser(name)
                                    : Preference.setMerchandiser1(name);
                                j == "0"
                                    ? Preference.setMerchandiserName(empName)
                                    : Preference.setMerchandiserName1(empName);
                                Navigator.pop(context);
                                j == "0"
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                JourneyManager("1")))
                                    : j == "2"
                                        ? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        JourneyManager("2")))
                                        : Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AddRelieverPage()));
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(filteredList1[index].toString()),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}
