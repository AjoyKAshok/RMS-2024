import 'package:flutter/material.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/NetworkModel/TodayCompletedJourney_Model.dart';

class Visited extends StatefulWidget {
  Data? data;

  Visited({super.key});
  @override
  State<Visited> createState() => _VisitedState(data);
}

class _VisitedState extends State<Visited> {
  int i = 0;
  Data? data;
  int lengthlist = 0;
  var myList = [];
  TodayCompletedJourneyModel? _data;
  _VisitedState(Data? data);
  _gettodayplanned() {
    ApiService.service.visited(context).then((value) => {
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
    return lengthlist != 0
        ? Center(
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
                              _data!.data![index].storeCode.toString() +
                                  _data!.data![index].storeName.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14),
                            ),
                            Text(
                              "${_data!.data![index].outletArea}    ${_data!.data![index].outletCity}   ${_data!.data![index].outletCountry}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                const Text("Contact Number"),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text(":"),
                                const SizedBox(
                                  width: 36,
                                ),
                                Text(
                                  _data!.data![index].contactNumber.toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 45,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
        : Container(
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "You seem to have not visited any stores for the Day... Please visit a store and check again...",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),
          );
  }
}
