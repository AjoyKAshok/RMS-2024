import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/SplashPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rms/FieldManager/HomePage.dart';

class MyAppGlobalLoaderOverlay extends StatelessWidget {
  Future<void> showLocationEnablePopup(BuildContext context) async {
    if (!(await Permission.location.status.isGranted)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Services Required'),
            content: Text('Please enable location services to use this feature.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // Redirects user to app settings
                },
                child: Text('Open Settings'),
              ),
            ],
          );
        },
      );
    }
  }
  void requestLocationPermission(BuildContext context) async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    // Handle the permission status
    if (status == PermissionStatus.granted) {
      // Permission granted, you can proceed with using location
      print('Location permission granted');
    } else {
      // Permission not granted, show a message or handle accordingly
      print('Location permission not granted');
    }
  }
  @override
  Widget build(BuildContext context) {
    requestLocationPermission(context);
    showLocationEnablePopup(context);
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RMS',
        theme: ThemeData(
          primaryColor:  Color(0XFFE84201),
          fontFamily: 'Baloo',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
        },
      ),
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitCubeGrid(
          color: Color(0XFFE84201),
          size: 50.0,
        ),
      ),
      overlayColor: Colors.white,
      overlayOpacity: 2,
      duration: Duration(seconds: 2),
    );
  }
}