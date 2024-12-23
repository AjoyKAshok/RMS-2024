import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Skipped_model.dart';

class ClientPendingDetails extends StatefulWidget {
  Data? data;
  String emp = "";
  int? index;
  ClientPendingDetails(this.emp, this.index, {super.key});

  @override
  State<ClientPendingDetails> createState() =>
      _ClientPendingDetailsState(data, emp, index);
}

class _ClientPendingDetailsState extends State<ClientPendingDetails> {
  int i = 0;
  Data? data;
  String emp = "";
  int lengthlist = 0;
  var myList = [];
  var pendingList = [];
  var date = DateTime.timestamp();
  int? index;
  SkippedModel? _data;
  _ClientPendingDetailsState(Data? data, this.emp, this.index);
  _gettodayplanned() async {
    print("The EmpId in fetching planned : $emp");
    await ApiServices.service.skipped(context, emp).then((value) => {
          setState(() {
            _data = value;
            myList.addAll(_data!.data!);
            lengthlist = myList.length;
          })
        });
    for (var i = 0; i < lengthlist; i++) {
      pendingList.add(_data!.data![i].storeName);
    }
    for (var j = 0; j < pendingList.length; j++) {
      print("Visited List -$j : ${pendingList[j]}");
    }
  }

  @override
  initState() {
    super.initState();
    print("Emp Id : ${this.emp}");
    _gettodayplanned();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            return Container(
                              child: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Pending Outlets",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    lengthlist > 0
                                        // ? Text(
                                        //     // "${passedList[index]['store_names']}",
                                        //     pendingList.toString(),

                                        //     // "$index",
                                        //     style:
                                        //         const TextStyle(fontSize: 13.6))
                                        ? Container(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                              itemCount: pendingList.length,
                                              itemBuilder: (context, index) {
                                                // return Text(pendingList[index]);
                                                 return Card(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                              "Store Name : ${pendingList[index]}"),
                                                        ),
                                                       
                                                      ],
                                                    ),
                                                  );
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 10.00,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }));
          },
          child: Text(
            "Pending : ",
            style: TextStyle(
                color: const Color(0XFFE84201).withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            return Container(
                              child: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Pending Outlets",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    lengthlist > 0
                                        // ? Text(
                                        //     // "${passedList[index]['store_names']}",
                                        //     pendingList.toString(),

                                        //     // "$index",
                                        //     style:
                                        //         const TextStyle(fontSize: 13.6))
                                        ? Container(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                              itemCount: pendingList.length,
                                              itemBuilder: (context, index) {
                                                // return Text(pendingList[index]);
                                                return Card(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                              "Store Name : ${pendingList[index]}"),
                                                        ),
                                                       
                                                      ],
                                                    ),
                                                  );
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 10.00,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }));
          },
          child: Text(
            lengthlist.toString(),
          ),
        ),
      ],
    );
  }
}
