import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOutletPage extends StatefulWidget {
  const AddOutletPage({super.key});

  @override
  State<AddOutletPage> createState() => _AddOutletPageState();
}

class _AddOutletPageState extends State<AddOutletPage> {
  String userName = "";
  String emp = "";
  bool _isLoaderVisible = false;

  TextEditingController outNameController = TextEditingController();
  TextEditingController outIdController = TextEditingController();
  TextEditingController outLatController = TextEditingController();
  TextEditingController outLongController = TextEditingController();

  _outlet() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
    print("User Name is : $userName");
    print("User Id is : $emp");
  }

  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
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
    });
  }

  outletNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Enter Outlet Name",
            labelStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          controller: outNameController,
        ),
      ),
    );
  }

  latitudeField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Enter Outlet Latitude",
            labelStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          controller: outLatController,
        ),
      ),
    );
  }

  longitudeField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Enter Outlet Longitude",
            labelStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          controller: outLongController,
        ),
      ),
    );
  }

  outletIdField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Enter Outlet Id",
            labelStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          controller: outIdController,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _outlet();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Add New Outlet"),
            userName.isNotEmpty
                ? Text(
                    "$userName($emp) - v ${AppVersion.version}",
                    style: const TextStyle(fontSize: 9, color: Colors.black),
                  )
                : const Text(""),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Pattern.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  outletNameField(),
                  latitudeField(),
                  longitudeField(),
                  outletIdField(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () {
                        print("Outlet Name : ${outNameController.text}");
                        print("Outlet Latitude : ${outLatController.text}");
                        print("Outlet Longitude : ${outLongController.text}");
                        print("Outlet Id : ${outIdController.text}");
                      },
                      style: TextButton.styleFrom(
                        // Text color
                        backgroundColor:
                            Colors.orange[300], // Button background color
                      ),
                      child: const Text(
                        'Add Outlet',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
