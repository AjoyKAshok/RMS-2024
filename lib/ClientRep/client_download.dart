import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rms/ClientRep/client_api_service.dart';
import 'package:rms/ClientRep/client_home.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientDownloadPage extends StatefulWidget {
  const ClientDownloadPage({super.key});

  @override
  State<ClientDownloadPage> createState() => _ClientDownloadPageState();
}

class _ClientDownloadPageState extends State<ClientDownloadPage> {
  int i = 0;

  int lengthlist = 0;
  int storeLengthList = 0;
  int listLength = 0;
  var myList = [];
  var myStoreList = [];
  var visitedList = [];
  var date = DateTime.now();

  String emp = "";
  String user = "";

  bool _isLoaderVisible = false;

  Future<void> saveExcelFile(dynamic response) async {
    try {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        // Request permission if not granted
        status = await Permission.storage.request();
        if (status.isDenied) {
          // Show settings dialog if permission is denied
          await openAppSettings();
          // AppSettings.openAppSettings(type: AppSettingsType.internalStorage);
          throw Exception('Storage permission required to save file');
        }
      }

      // Handle permanently denied case
      if (status.isPermanentlyDenied) {
        // Show dialog to open settings
        bool openSettings = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Storage Permission Required'),
                content: const Text(
                  'Storage permission is required to save files. Please enable it in settings.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
            ) ??
            false;

        if (openSettings) {
          await openAppSettings();
        }
        throw Exception('Storage permission required to save file');
      }

      // Continue with file saving if permission is granted
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String filePath = '${directory.path}/report_$timestamp.xlsx';

      if (response is String) {
        File file = File(filePath);
        await file.writeAsBytes(response.codeUnits);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File saved successfully at: $filePath'),
            backgroundColor: Colors.green,
          ),
        );

        await OpenFile.open(filePath);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error saving file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving file: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> _checkAndRequestPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt >= 33) {
        // Android 13 and above
        final status = await Permission.photos.status;
        if (status.isDenied) {
          final result = await Permission.photos.request();
          return result.isGranted;
        }
        return true;
      } else {
        // Below Android 13
        final status = await Permission.storage.status;
        if (status.isDenied) {
          final result = await Permission.storage.request();
          return result.isGranted;
        }
        return true;
      }
    }
    return true; // iOS doesn't need runtime permission for storage
  }

  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
      dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
      todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
    });
  }

  DateTime selectedDate = DateTime.now();
  String? dateToUse;
  String? fromDate;
  String? toDate;
  String? todayDate;
  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        fromDate = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
        print("The selected date is : $dateToUse");
        print("The from date is : $fromDate");

        print("Todays Date : $todayDate");
        myList = [];
        lengthlist = 0;
        // _gettodayplanned();
      });

      // Here you can call a method to refresh data based on the new date
      // For example: _refreshDataForDate(selectedDate);
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        toDate = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
        print("The selected date is : $dateToUse");
        print("The to date is : $toDate");
        print("Todays Date : $todayDate");
        myList = [];
        lengthlist = 0;
        // _gettodayplanned();
      });

      // Here you can call a method to refresh data based on the new date
      // For example: _refreshDataForDate(selectedDate);
    }
  }

  bool isLoading = false;

  Future<void> saveFile(dynamic response) async {
    try {
      // Check permission
      bool hasPermission = await FileService.checkPermission();
      if (!hasPermission) {
        // Show permission dialog
        bool openSettings = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Storage Permission Required'),
                content: const Text(
                  'Storage permission is required to save files. Please enable it in settings.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
            ) ??
            false;

        if (openSettings) {
          await openAppSettings();
        }
        return;
      }

      setState(() => isLoading = true);

      // Get download path
      String downloadPath = await FileService.getDownloadPath();

      // Create filename with timestamp
      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String filePath = '$downloadPath/file_$timestamp.xlsx';

      // Save file
      File file = File(filePath);
      await file.writeAsBytes(response);

      // Show success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File saved to: $filePath'),
          backgroundColor: Colors.green,
        ),
      );

      // Open file
      await OpenFile.open(filePath);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving file: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  _gettodayplanned() async {
    try {
      SharedPreferences prefs1 = await SharedPreferences.getInstance();
      // emp=prefs1.get("id").toString();
      user = prefs1.get("user").toString();
      print("The From Date : $fromDate");
      print("The To Date : $toDate");
      if (fromDate != null && toDate != null) {
        var response = await ClientApiService.clientservice
            .downloadReport(fromDate, toDate);

        if (response != null) {
          // await saveExcelFile(response);
          await saveFile(response);
        }
      } else {
        // setState(() {
        //   dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        //   todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
        // });
        print("Please select From and To Dates");
        throw Exception('Failed to download file');
      }
    } catch (e) {
      print('Error downloading report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Error downloading report: Please select From and To Dates'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  initState() {
    super.initState();

    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientHome()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0XFF909090),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Download Reports"),
            Text(
              "$user($emp) - v ${AppVersion.version}",
              style: TextStyle(
                  color: Colors.black.withOpacity(.6),
                  fontSize: 8,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Pattern.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: fromDate != null
                          ? Text(
                              'From Date: $fromDate',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFE84201),
                              ),
                            )
                          : const Text(
                              "From Date : Select From Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFE84201),
                              ),
                            ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectFromDate(context);
                          print("Todays Date : $todayDate");
                          print("Selected Date : $dateToUse");

                          setState(() {});
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: toDate != null
                          ? Text(
                              'To Date: $toDate',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFE84201),
                              ),
                            )
                          : const Text(
                              "To Date : Select To Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFE84201),
                              ),
                            ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectToDate(context);
                          print("Todays Date : $todayDate");
                          print("Selected Date : $dateToUse");

                          setState(() {});
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _gettodayplanned();
                    },
                    child: const Text('Download Data'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FileService {
  static Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt >= 33) {
        // Android 13 and above
        final status = await Permission.photos.status;
        if (status.isDenied) {
          final result = await Permission.photos.request();
          return result.isGranted;
        }
        return true;
      } else {
        // Below Android 13
        final status = await Permission.storage.status;
        if (status.isDenied) {
          final result = await Permission.storage.request();
          return result.isGranted;
        }
        return true;
      }
    }
    return true; // iOS doesn't need runtime permission
  }

  static Future<String> getDownloadPath() async {
    if (Platform.isAndroid) {
      return '/storage/emulated/0/Download';
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }
}
