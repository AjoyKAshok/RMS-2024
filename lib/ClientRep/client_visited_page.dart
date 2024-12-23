import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Visited_model.dart';

class ClientVisitedDetails extends StatefulWidget {
  Data? data;
  String emp = "";
  int? index;
  ClientVisitedDetails(this.emp, this.index, {super.key});

  @override
  State<ClientVisitedDetails> createState() => _ClientVisitedDetailsState(data, emp, index);
}

class _ClientVisitedDetailsState extends State<ClientVisitedDetails> {
  int i = 0;
  Data? data;
  String emp = "";
  int lengthlist = 0;
  var myList = [];
  var visitedList = [];
  var date = DateTime.timestamp();
  VisitedModel? _data;
  int? index;
  _ClientVisitedDetailsState(Data? data, this.emp, this.index);

  _gettodayplanned() async {
    await ApiServices.service.visited(context, emp).then((value) => {
          // print("Value : ${value.data![0].storeName}"),
          setState(() {
            _data = value;
            myList.addAll(_data!.data!);
            lengthlist = myList.length;
          })
        });
    // print("My List : ${_data!.data!.length}");
    for (var i = 0; i < lengthlist; i++) {
      visitedList.add(_data!.data![i].storeName);
    }
    for (var j = 0; j < visitedList.length; j++) {
      print("Visited List -$j : ${visitedList[j]}");
    }
  }

  @override
  initState() {
    super.initState();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          "Visited Outlets",
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
                                          //     // _data!.data![index!].storeName
                                          //     //     .toString(),
                                          //     visitedList.toString(),
                                          //     style: const TextStyle(
                                          //         fontSize: 13.6))
                                          ? SizedBox(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView.builder(
                                                itemCount: visitedList.length,
                                                itemBuilder: (context, index) {
                                                  return 
                                                  
                                                    Card(
                                                      child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                                "Store Name : ${visitedList[index]}", textAlign: TextAlign.center,),
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
            "Visited : ",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          "Visited Outlets",
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
                                          //     // _data!.data![index!].storeName
                                          //     //     .toString(),
                                          //     visitedList.toString(),
                                          //     style: const TextStyle(
                                          //         fontSize: 13.6))
                                          ? SizedBox(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView.builder(
                                                itemCount: visitedList.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                              "Store Name : ${visitedList[index]}"),
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
            )),
      ],
    );
  }
}
