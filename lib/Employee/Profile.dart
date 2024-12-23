
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   String emp="";
   String user="";
  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp=prefs1.get("id").toString();
    user=prefs1.get("user").toString();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(Duration(seconds: 1));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }
  @override
  void initState() {
    super.initState();
    loader();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          foregroundColor: Colors.black.withOpacity(.6),
          title: Text("My Profile",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 21,fontWeight: FontWeight.w500),),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Pattern.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      CircleAvatar(
                        radius: 45,
                        child: Icon(Icons.person,size: 75,color: Color(0XFFE84201),),
                      ),
                      SizedBox(height: 10,),
                      Text(user,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                      Text(emp),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Personal Info",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Full Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": "+user,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Email",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Joining Date",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": 2021-05-05",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Department",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": Merchandiser",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Nationality",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": Indian",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Visa Company",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": Green Apple",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Visa Expiry Date",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": 2021-05-31",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Passport Expiry",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": 2021-05-31",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Update Info",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*.41,
                              child: Text("Mobile Number",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height:5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width:MediaQuery.of(context).size.width*.41,
                                  child: Text("Change Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                          Text(": ********",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                            ],
                          ),
                          Icon(Icons.edit,color: Color(0XFFE84201),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}