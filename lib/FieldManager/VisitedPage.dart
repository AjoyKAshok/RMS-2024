import 'package:flutter/material.dart';
import 'package:rms/FieldManager/ApiService.dart';
import 'package:rms/NetworkModelfm/Visited_model.dart';

class VisitedPage extends StatefulWidget {
  Data? data;
  String emp = "";
  int? index;
  VisitedPage(this.emp, this.index, {super.key});
  @override
  State<VisitedPage> createState() => _VisitedPageState(data, emp, index);
}

class _VisitedPageState extends State<VisitedPage> {
  int i = 0;
  Data? data;
  String emp = "";
  int lengthlist = 0;
  var myList = [];
  var visitedList = [];
  var date = DateTime.timestamp();
  VisitedModel? _data;
  int? index;
  _VisitedPageState(Data? data, this.emp, this.index);

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
    for(var j = 0; j<visitedList.length; j++){
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
        Text(
          "Visited : ",
          style: TextStyle(
              color: const Color(0XFFE84201).withOpacity(.8),
              fontWeight: FontWeight.w400,
              fontSize: 13),
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
                                          ? Container(
                                              height: 300,
                                              width: MediaQuery.of(context).size.width,
                                              child: ListView.builder(
                                                itemCount: visitedList.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: Column(
                                                      children: [
                                                        Text("Store Name : ${visitedList[index]}"),
                                                        
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
