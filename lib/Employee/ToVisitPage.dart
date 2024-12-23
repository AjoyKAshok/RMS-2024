import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/NetworkModel/TodaySkippedJourney_Model.dart';

class ToVisit extends StatefulWidget {
  Data? data;
  double a = 0.0;
  double b = 0.0;
  ToVisit(this.a, this.b, {super.key});
  @override
  State<ToVisit> createState() => _ToVisitState(data, a, b);
}

class _ToVisitState extends State<ToVisit> {
  int i = 0;
  String km = "";
  Data? data;
  int lengthlist = 0;
  var myList = [];
  double a = 0.0;
  double b = 0.0;
  TodaySkippedJourneyModel? _data;
  _ToVisitState(Data? data, this.a, this.b);
  _gettodayplanned() {
    ApiService.service.tovisit(context).then((value) => {
          setState(() {
            _data = value;
            myList.addAll(_data!.data!);
            lengthlist = myList.length;
          })
        });
  }

  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
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
                  km = _calculateDistance(
                          a,
                          b,
                          double.parse(
                              _data!.data![index].outletLat.toString()),
                          double.parse(
                              _data!.data![index].outletLong.toString()))
                      .toString();
                  km = (double.parse(km) / 1000).toString();
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
                              _data!.data![index].storeCode.toString() + " - " +
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
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Icon(
                                      Icons.phone,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
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
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.blue,
                                  child: const Center(
                                    child: Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "$km KM",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 12),
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
                  "You seem to have no active Journey Plans for the Day... Please check with your Field Manager...",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),
          );
  }
}
