import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rms/Employee/MyGlobalLoader.dart';
import 'package:rms/Employee/SplashPage.dart';
import 'package:rms/FieldManager/HomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyAppGlobalLoaderOverlay());
}

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    requestLocationPermission(context);
    showLocationEnablePopup(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RMS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: SplashPage(),
      ),
    );
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
}
