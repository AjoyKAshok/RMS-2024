import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/ClientRep/client_download.dart';
import 'package:rms/ClientRep/client_merch_list.dart';
import 'package:rms/ClientRep/client_outofstock.dart';
import 'package:rms/ClientRep/client_replenish.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/LoginPage.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  String userName = "";
  String emp = "";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  _getdashboard() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    userName = prefs1.get("user").toString();
    emp = prefs1.get("id").toString();
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    // SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 5));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  loadVals() async {
    await _getdashboard();
  }

  @override
  initState() {
    super.initState();
    loadVals();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => scaffoldKey.currentState?.openDrawer(),
                    child: Image.asset(
                      "images/NewRMSMenu.png",
                      width: 34,
                      height: 25,
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/rmsLogo.png",
                      width: 70,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "$userName($emp) - New Version${AppVersion.version}",
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0XFFE84201),
                ), //BoxDecoration
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0XFFE84201),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Menu",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(userName,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ) //UserAccountDrawerHeader
                ), //DrawerHeader

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, size: 25),
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                var response = ApiService.service.logout(context);
                response.then((value) => {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      }),
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                              child: Text("You have successfully logged out!")),
                          backgroundColor: Color(0XFFE84201),
                        ),
                      ),
                    });
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Pattern.png"),
            fit: BoxFit.fill,
          ),
        ),
        // child: Center(
        child: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientMerchList()),
                      );
                    },
                    child: const Card(
                      color: Color(0xfff5e1d5),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, right: 35, left: 35),
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_graph,
                              size: 50,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Time Sheet",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ClientOutOfStockDetails()),
                      );
                    },
                    child: const Card(
                      color: Color(0xfff5e1d5),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, right: 30, left: 30),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warehouse_outlined,
                              size: 50,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Out of Stock",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ClientReplenishDetails()),
                      );
                    },
                    child: const Card(
                      color: Color(0xfff5e1d5),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, right: 45, left: 30),
                        child: Row(
                          children: [
                            Icon(
                              Icons.store_mall_directory_outlined,
                              size: 50,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Replenishment",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientDownloadPage()),
                      );
                    },
                    child: const Card(
                      color: Color(0xfff5e1d5),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, right: 45, left: 30),
                        child: Row(
                          children: [
                            Icon(
                              Icons.download_outlined,
                              size: 50,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        var response = ApiService.service.logout(context);
                        response.then((value) => {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              }),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                      child: Text(
                                          "You have successfully logged out!")),
                                  backgroundColor: Color(0XFFE84201),
                                ),
                              ),
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade900),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
      // ),
    );
  }
}
