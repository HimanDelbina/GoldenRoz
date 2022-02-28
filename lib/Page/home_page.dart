import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nima/Model/buinfo_model.dart';
import 'package:nima/Page/ListAmalkard/amalkard_page.dart';
import 'package:nima/Page/page_show.dart';
import 'package:nima/Provider/page_bloc.dart';
import 'package:nima/Static/static_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getBuinfo();
  }

  bool perAmalkard = false;
  bool perHazine = false;
  bool perNobat = false;
  bool perNobatList = false;
  bool perHistory = false;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text("تایید"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("خروج"),
      content: const Text("لطفا برای خروج از منوی زیر اقدام فرمایید"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/rg.png"),
              ),
            ),
            title: Row(
              children: [
                Text(firstName == null ? "" : firstName.toString(),
                    style:
                        const TextStyle(color: Colors.black, fontSize: 14.0)),
                const SizedBox(
                  width: 10,
                ),
                Text(lastName == null ? "" : lastName.toString(),
                    style:
                        const TextStyle(color: Colors.black, fontSize: 14.0)),
              ],
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    perAmalkard
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Amalkard(),
                                  ));
                            },
                            child: Container(
                              height: myHeight * 0.2,
                              width: myWidth * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/icon/Bulk/Ticket.png",
                                    height: 70,
                                    color: Colors.purpleAccent,
                                  ),
                                  const Text(
                                    "لیست عملکرد",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                          ),
                    perHazine
                        ? Container(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/icon/Bulk/Ticket.png",
                                  height: 70,
                                ),
                                const Text(
                                  "لیست هزینه",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                          ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    perNobat
                        ? Container(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/icon/Bulk/Ticket.png",
                                  height: 70,
                                ),
                                const Text(
                                  "لیست نوبت روزانه",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                          ),
                    perNobatList
                        ? Container(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/icon/Bulk/Ticket.png",
                                  height: 70,
                                ),
                                const Text(
                                  "ثبت نوبت روزانه",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: myHeight * 0.2,
                            width: myWidth * 0.4,
                          ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  String? firstName;
  String? lastName;
  Future<List<Buinfo>?> getBuinfo() async {
    var buinfo;
    List? buinfoPer;
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      const infourl = 'http://128.65.186.187:1989/api/buinfo';
      // const infourl = 'http://93.115.144.242:5001/api/buinfo';
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(utf8.decode(response.bodyBytes));
        var listBuinfo = Buinfo.fromJson(x);
        setState(() {
          buinfo = listBuinfo;
          buinfoPer = buinfo.permissions;
          firstName = buinfo.userName;
          lastName = buinfo.userFamily;
        });
        StaticFile.userName = buinfo.userName;
        StaticFile.userFamily = buinfo.userFamily;
        StaticFile.gender = buinfo.gender;
        StaticFile.isActive = buinfo.isActive;
        StaticFile.roleId = buinfo.roleId;
        StaticFile.permissions = buinfo.permissions;
        print("ok");
        for (var i = 0; i < buinfoPer!.length; i++) {
          if (buinfoPer![i] == 1) {
            setState(() {
              perAmalkard = true;
            });
          } else if (buinfoPer![i] == 2) {
            setState(() {
              perHazine = true;
            });
          } else if (buinfoPer![i] == 3) {
            setState(() {
              perNobat = true;
            });
          } else if (buinfoPer![i] == 4) {
            setState(() {
              perNobatList = true;
            });
          } else if (buinfoPer![i] == 5) {
            setState(() {
              perHistory = true;
            });
          }
        }
      }
    }
  }
}
