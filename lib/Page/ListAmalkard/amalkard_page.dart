import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nima/Model/boperation_model.dart';
import 'package:nima/Page/ListAmalkard/first_form_sabt.dart';
import 'package:nima/Page/ListAmalkard/history_page.dart';
import 'package:nima/Page/page_show.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../home_page.dart';
import 'history_jalasat.dart';

class Amalkard extends StatefulWidget {
  const Amalkard({Key? key}) : super(key: key);

  @override
  _AmalkardState createState() => _AmalkardState();
}

class _AmalkardState extends State<Amalkard> with TickerProviderStateMixin {
  TabController? controller;
  int selectedIndex = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    getboperation();
    controller = TabController(length: 2, vsync: this);
    controller!.addListener(() {
      setState(() {
        selectedIndex = controller!.index;
      });
      if (selectedIndex == 0) {
        if (_start == 0) {
          setState(() {
            _start = 10;
          });
          startTimer();
        } else {
          startTimer();
        }
      } else if (selectedIndex == 1) {
        if (_start == 0) {
          setState(() {
            _start = 10;
          });
          startTimer();
        } else {
          startTimer();
        }
      }
    });
  }

  Timer? _timer;
  int _start = 10;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PageShow(),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "لیست عملکرد",
            style: TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.purpleAccent,
          ),
        ),
        body: SafeArea(
            child: boperation!.length == 0
                ? Center(
                    child: _start == 0
                        ? const Text("لیستی برای ثبت پرداخت وجود ندارد")
                        : Lottie.asset("assets/animations/loading.json",
                            height: 100))
                : RefreshIndicator(
                    key: refreshKey,
                    onRefresh: refreshList,
                    child: ListView.builder(
                      itemCount: boperation!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstFormSabt(
                                      editid: 0,
                                      id: boperation![index].id,
                                      gender: boperation![index].gender,
                                      name: boperation![index].userName +
                                          " " +
                                          boperation![index].userFamily,
                                    ),
                                  ));
                            },
                            child: Container(
                              // height: myHeight * 0.08,
                              width: myWidth,
                              decoration: BoxDecoration(
                                  color: boperation![index].status == "0"
                                      ? Colors.grey.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: boperation![index].status == "0"
                                          ? Colors.grey.withOpacity(0.4)
                                          : Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: myHeight * 0.05,
                                                width: myWidth * 0.1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: boperation![
                                                                        index]
                                                                    .status ==
                                                                "0"
                                                            ? Colors
                                                                .purpleAccent
                                                                .withOpacity(
                                                                    0.5)
                                                            : Colors.blue
                                                                .withOpacity(
                                                                    0.5)),
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: boperation![index]
                                                                .status ==
                                                            "0"
                                                        ? Image.asset(
                                                            "assets/icon/Bulk/Show.png",
                                                            height: 25,
                                                          )
                                                        : Image.asset(
                                                            "assets/icon/Bulk/Wallet.png",
                                                            height: 20,
                                                            // color: Colors.green
                                                            //     .withOpacity(0.5),
                                                          )),
                                              ),
                                              Text(
                                                boperation![index].regtime,
                                                style: const TextStyle(
                                                    fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            boperation![index].userName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            boperation![index].userFamily,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    boperation![index].status == "1"
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HistoryJalasat(
                                                      id: boperation![index].id,
                                                      gender: boperation![index]
                                                          .gender,
                                                    ),
                                                  ));
                                            },
                                            child: Container(
                                              height: myHeight * 0.065,
                                              width: myWidth * 0.12,
                                              decoration: BoxDecoration(
                                                  color: boperation![index]
                                                              .status ==
                                                          "0"
                                                      ? Colors.purpleAccent
                                                          .withOpacity(0.2)
                                                      : Colors.blue
                                                          .withOpacity(0.2),
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/icon/Bulk/Edit.png",
                                                  height: 30,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(width: 10.0),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HistoryPage(
                                                id: boperation![index].id,
                                                name: boperation![index]
                                                        .userName +
                                                    " " +
                                                    boperation![index]
                                                        .userFamily,
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: myHeight * 0.065,
                                        width: myWidth * 0.12,
                                        decoration: BoxDecoration(
                                            color: boperation![index].status ==
                                                    "0"
                                                ? Colors.purpleAccent
                                                    .withOpacity(0.2)
                                                : Colors.blue.withOpacity(0.2),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/icon/Bulk/Calendar.png",
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
      ),
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      getboperation();
    });
  }

  List? boperation = [];
  List? boperationStatus0 = [];
  List? boperationStatus1 = [];
  var boperationList;
  Future<List<Boperation>?> getboperation() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      const infourl = 'http://128.65.186.187:1989/api/boperation';
      // const infourl = 'http://93.115.144.242:5001/api/boperation';
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        boperationList = x.map((e) => Boperation.fromJson(e)).toList();
        setState(() {
          boperation = boperationList;
        });
      }
    }
  }
}
