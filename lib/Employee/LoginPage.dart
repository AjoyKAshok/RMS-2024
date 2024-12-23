import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool passwordVisible = false;
  int button =0;
  String _lastPage = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getString('page') ?? 'Login';
    });
  }

  void _saveLastPage(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('page', page);
  }


  // Initialize connectivity status
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  // Update the UI based on the connectivity status
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result;
    });
    if (result == ConnectivityResult.none) {
      _showNoConnectionDialog();
    }
  }

  
  void openAppSettings() async {
  const url = 'app-settings:';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open app settings';
  }
}

  void _showNoConnectionDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You have lost your internet connection.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // AppSettings.openAppSettings(type: AppSettingsType.wifi);
                Platform.isIOS ? openAppSettings() : AppSettings.openAppSettingsPanel(
                    AppSettingsPanelType.internetConnectivity);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  checkNetwork() async {
    await _initConnectivity();
  }

  fetchNetwork() async {
    print("Network Check from Login Page");
    await checkNetwork();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _saveLastPage("Login");
    passwordVisible = true;
    fetchNetwork();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _appState = state;
    _getLastPage();
    print("App State is : $_appState");
    if (state == AppLifecycleState.resumed) {
      // myList.clear();
      print("Calling Life Cycle Change Events");
      if (_lastPage == "Login") {
        print("Calling Functions for Login Page");
        await Future.delayed(const Duration(seconds: 4));
        setState(() {
          fetchNetwork();
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Pattern.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 90,
                  ),
                  Image.asset(
                    "images/rmsLogo.png",
                    width: MediaQuery.of(context).size.width * .33,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Hello!\nWelcome Back",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const Text(
                    "Log into Your Account",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color(0XFFE84201)), //<-- SEE HERE
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.red), //<-- SEE HERE
                        ),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                          color: Color(0XFFE84201),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: validateEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: TextFormField(
                      obscureText: passwordVisible,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.black), //<-- SEE HERE
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.black), //<-- SEE HERE
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color(0XFFE84201)), //<-- SEE HERE
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.red), //<-- SEE HERE
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Color(0XFFE84201),
                          )),
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Process registration
                        // For example, you can send data to your server
                        // or perform any required action here
                        var response = ApiService.service.login(context,
                            _emailcontroller.text.trim(), _passwordcontroller.text.trim());
                        response.then((value) => {});
                      }
                      setState(() {
                        button=1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient:  LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [button==0?Color(0xFFF88200):Colors.grey, button==0?Color(0xFFE43700):Colors.grey]),
                        ),
                        child: const Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
