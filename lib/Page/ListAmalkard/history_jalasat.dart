import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nima/Model/history_jalasta_model.dart';
import 'package:nima/Page/Edit/edit_first.dart';
import 'package:nima/Page/Edit/edit_second.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'amalkard_page.dart';

class HistoryJalasat extends StatefulWidget {
  int? id;
  int? gender;
  HistoryJalasat({Key? key, this.id, this.gender}) : super(key: key);

  @override
  _HistoryJalasatState createState() => _HistoryJalasatState();
}

class _HistoryJalasatState extends State<HistoryJalasat> {
  @override
  void initState() {
    super.initState();
    gethistory();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        child: ListView.builder(
          itemCount: historyJalasat!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          historyJalasat![index].select =
                              !historyJalasat![index].select;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: [
                            const Text("ناحیه لیزر :"),
                            const SizedBox(width: 5),
                            Text(historyJalasat![index].area),
                            const SizedBox(width: 20),
                            Text(historyJalasat![index].amount),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditFirstPage(
                                        editid: historyJalasat![index].id,
                                        id: widget.id,
                                        gender: widget.gender,
                                        jalasat: historyJalasat![index],
                                      ),
                                    ));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/icon/Bulk/Edit.png",
                                      height: 25,
                                      color: Colors.blue,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  deleteIdHistory = historyJalasat![index].id;
                                });
                                showAlertDialog(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/icon/Bulk/Delete.png",
                                      height: 25,
                                      color: Colors.red,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    historyJalasat![index].select
                        ? Container(
                            height: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("هندپیس :"),
                                          Text(
                                            historyJalasat![index]
                                                .handpis
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("پالس :"),
                                          Text(
                                            historyJalasat![index]
                                                .pals
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("طول موج :"),
                                          Text(
                                            historyJalasat![index]
                                                .moj
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("انرژی :"),
                                          Text(
                                            historyJalasat![index]
                                                .energy
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("دستگاه :"),
                                          Text(
                                            historyJalasat![index]
                                                .device
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(),
                                      const SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("خیر"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("بله"),
      onPressed: () {
        deleteHistory();
        setState(() {});
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("حذف عملرد"),
      content:
          const Text("آیا مطمئن هستید که می خواهید این عملکرد را حذف کنید"),
      actions: [
        cancelButton,
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

  List? historyJalasat = [];
  var historyJalasatList = [];
  Future<List<HistoryJalasatModel>?> gethistory() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl = 'http://128.65.186.187:1989/api/boperation/sessiond/' +
          widget.id.toString();
      // String infourl = 'http://93.115.144.242:5001/api/boperation/sessiond/' +
      //     widget.id.toString();
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        historyJalasatList =
            x.map((e) => HistoryJalasatModel.fromJson(e)).toList();
        setState(() {
          historyJalasat = historyJalasatList;
        });
        print(historyJalasat);
      }
    }
  }

  int? deleteIdHistory = 0;
  Future deleteHistory() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl = 'http://128.65.186.187:1989/api/boperation/del/' +
          deleteIdHistory.toString();
      // String infourl = 'http://93.115.144.242:5001/api/boperation/del/' +
      //     deleteIdHistory.toString();
      var response = await http.post(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        if (x['message'] == "1") {
          // Navigator.of(context).pop();
          setState(() {
            gethistory();
          });
          if (historyJalasat!.length == 1) {
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Amalkard(),
            ));
          }

          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            duration: const Duration(seconds: 2),
            content: const Text(
              'عملکرد با موفقیت حذف شد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Vazir",
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          duration: const Duration(seconds: 2),
          content: const Text(
            'عملکرد حذف نشد لطفا دوباره امتحان کنید',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Vazir",
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
