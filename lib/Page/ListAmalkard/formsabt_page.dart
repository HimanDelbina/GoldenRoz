import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nima/Model/barea_model.dart';
import 'package:nima/Model/boperation_form.dart';
import 'package:nima/Model/boperationformpost_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'amalkard_page.dart';

class FormSabt extends StatefulWidget {
  final String? name;
  final int? gender;
  final int? id;
  final List<int>? select;
  final int? packid;
  final int? editid;
  const FormSabt(
      {Key? key,
      this.name,
      this.gender,
      this.id,
      this.select,
      this.packid,
      this.editid})
      : super(key: key);

  @override
  _FormSabtState createState() => _FormSabtState();
}

class _FormSabtState extends State<FormSabt> {
  @override
  void initState() {
    getbeoperation();
    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  String? selectShat;
  TextEditingController controllerselectShat = TextEditingController();
  String? selecttime;
  TextEditingController controllerselectTime = TextEditingController();

  int? deviceSelect = 0;
  String? devicePost = "";
  int? mojSelect = 0;
  String? mojPost = "";
  int? amountSelect = 0;
  String? amountPost = "";
  int? tipSelect = 0;
  String? tipPost = "";
  int? handpisSelect = 0;
  int? handpisPost = 0;
  int? palsSelect = 0;
  int? palsPost = 0;
  int? energySelect = 0;
  int? energyPost = 0;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "فرم ثبت عملکرد" + " " + widget.name!.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.purpleAccent,
            ),
          ),
          body: beoperation!.length != 0
              ? Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView(
                        children: [
                          amount[0].length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('مقدار')],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: amount[0].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 5,
                                                mainAxisExtent: 60.0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  amountSelect =
                                                      amount[0][index].id;
                                                  amountPost =
                                                      amount[0][index].title;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: amount[0][index].id ==
                                                          amountSelect
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.grey
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  amount[0][index].title,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight: amount[0]
                                                                      [index]
                                                                  .id ==
                                                              amountSelect
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      color:
                                                          amount[0][index].id ==
                                                                  amountSelect
                                                              ? Colors.white
                                                              : Colors.black),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text("amount"),
                          const Divider(indent: 10, endIndent: 10),
                          tip[0].length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('تیپ پوستی')],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: tip[0].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 6),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tipSelect = tip[0][index].id;
                                                  tipPost = tip[0][index].title;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: tip[0][index].id ==
                                                          tipSelect
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.grey
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  tip[0][index].title,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: tip[0][index].id ==
                                                              tipSelect
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: tip[0][index]
                                                                  .id ==
                                                              tipSelect
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text("tip"),
                          const Divider(indent: 10, endIndent: 10),
                          handpis[0].length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('هندپیس')],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: handpis[0].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  handpisSelect =
                                                      handpis[0][index].id;
                                                  handpisPost =
                                                      handpis[0][index].value;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: handpis[0][index].id ==
                                                          handpisSelect
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.grey
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  handpis[0][index]
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: handpis[0][index]
                                                                  .id ==
                                                              handpisSelect
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: handpis[0]
                                                                      [index]
                                                                  .id ==
                                                              handpisSelect
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text("handpis"),
                          const Divider(indent: 10, endIndent: 10),
                          device[0].length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('دستگاه')],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: device[0].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisExtent: 60.0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  deviceSelect =
                                                      device[0][index].id;
                                                  devicePost =
                                                      device[0][index].title;
                                                });
                                                if (deviceSelect != 0 &&
                                                    mojSelect != 0) {
                                                  await postdevice();
                                                  setState(() {
                                                    pals = pals;
                                                    energy = energy;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: device[0][index].id ==
                                                          deviceSelect
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.grey
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  device[0][index].title,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color:
                                                          device[0][index].id ==
                                                                  deviceSelect
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight: device[0]
                                                                      [index]
                                                                  .id ==
                                                              deviceSelect
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text("device"),
                          const Divider(indent: 10, endIndent: 10),
                          moj[0].length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('طول موج')],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: moj[0].length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisExtent: 60.0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  mojSelect = moj[0][index].id;
                                                  mojPost = moj[0][index].title;
                                                });
                                                if (deviceSelect != 0 &&
                                                    mojSelect != 0) {
                                                  await postdevice();
                                                  setState(() {
                                                    pals = pals;
                                                    energy = energy;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: moj[0][index].id ==
                                                          mojSelect
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.grey
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  moj[0][index].title,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: moj[0][index].id ==
                                                              mojSelect
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: moj[0][index]
                                                                  .id ==
                                                              mojSelect
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text("moj"),
                          const Divider(indent: 10, endIndent: 10),
                          beoperationPost!.length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('پالس')],
                                        ),
                                      ),
                                      mojSelect != 0 && deviceSelect != 0
                                          ? GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: pals[0].length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 8),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        palsSelect =
                                                            pals[0][index].id;
                                                        palsPost = pals[0]
                                                                [index]
                                                            .value;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: pals[0][index]
                                                                    .id ==
                                                                palsSelect
                                                            ? Colors
                                                                .deepPurpleAccent
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        pals[0][index]
                                                            .value
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: pals[0][index]
                                                                        .id ==
                                                                    palsSelect
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight: pals[0][
                                                                            index]
                                                                        .id ==
                                                                    palsSelect
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                      )),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: const [
                                                  Text(
                                                      "لطفا طول موج و دستگاه را انتخاب کنید"),
                                                ],
                                              ),
                                            )
                                    ],
                                  ))
                              : Column(
                                  children: const [
                                    Text(
                                        "لطفا طول موج و دستگاه را انتخاب کنید"),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: LinearProgressIndicator(),
                                    ),
                                  ],
                                ),
                          const Divider(indent: 10, endIndent: 10),
                          beoperationPost!.length != 0
                              ? Container(
                                  width: myWidth,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 2.0),
                                        child: Row(
                                          children: const [Text('انرژی')],
                                        ),
                                      ),
                                      mojSelect != 0 && deviceSelect != 0
                                          ? GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: energy[0].length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 8),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        energySelect =
                                                            energy[0][index].id;
                                                        energyPost = energy[0]
                                                                [index]
                                                            .value;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: energy[0][index]
                                                                    .id ==
                                                                energySelect
                                                            ? Colors
                                                                .deepPurpleAccent
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        energy[0][index]
                                                            .value
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: energy[0][
                                                                            index]
                                                                        .id ==
                                                                    energySelect
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight: energy[0]
                                                                            [
                                                                            index]
                                                                        .id ==
                                                                    energySelect
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                      )),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: const [
                                                  Text(
                                                      "لطفا طول موج و دستگاه را انتخاب کنید"),
                                                ],
                                              ),
                                            )
                                    ],
                                  ))
                              : Column(
                                  children: const [
                                    Text(
                                        "لطفا طول موج و دستگاه را انتخاب کنید"),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: LinearProgressIndicator(),
                                    ),
                                  ],
                                ),
                          const Divider(indent: 10, endIndent: 10),
                          Row(
                            children: [
                              Container(
                                width: myWidth * 0.6,
                                child: TextFormField(
                                    onSaved: (value) => selectShat = value,
                                    controller: controllerselectShat,
                                    onChanged: (value) {
                                      setState(() {
                                        selectShat = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    maxLength: 5,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                        label: Text("شات"),
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: "شات",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ))),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                    onSaved: (value) => selecttime = value,
                                    controller: controllerselectTime,
                                    onChanged: (value) {
                                      setState(() {
                                        selecttime = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                        label: Text("زمان"),
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: "زمان",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.purpleAccent,
                                          ),
                                        ))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                    Container(
                      height: myHeight * 0.1,
                      width: myWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: sabtButton!
                            ? GestureDetector(
                                onTap: () {
                                  postform();
                                },
                                child: Container(
                                  height: myHeight,
                                  width: myWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "ثبت عملکرد",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Lottie.asset("assets/animations/loading.json",
                      height: 100.0))),
    );
  }

  var amountbool = [];
  var tipbool = [];
  var handpisbool = [];
  var devicebool = [];
  var mojbool = [];
  var palsbool = [];
  var energybool = [];

  int? amountIndex;

  List? beoperation = [];
  var beoperationList = [];
  var amount = [];
  var tip = [];
  var handpis = [];
  var device = [];
  var moj = [];

  Future<List<Boperationform>?> getbeoperation() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl = 'http://128.65.186.187:1989/api/boperationform';
      // String infourl = 'http://93.115.144.242:5001/api/boperationform';
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        beoperationList = x.map((e) => Boperationform.fromJson(e)).toList();
        setState(() {
          beoperation = beoperationList;
          amount.add(beoperation![0].amount);
          tip.add(beoperation![0].tip);
          handpis.add(beoperation![0].handpis);
          device.add(beoperation![0].device);
          moj.add(beoperation![0].moj);
        });
        print(amount);
      }
    }
  }

  List? beoperationPost = [];
  var beoperationPostList = [];
  var pals = [];
  var energy = [];
  Future<List<BoperationformPost>?> postdevice() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    var body = json.encode({
      "Device": deviceSelect,
      "Moj": mojSelect,
    });
    if (token != null) {
      String infourl = 'http://128.65.186.187:1989/api/boperationform';
      // String infourl = 'http://93.115.144.242:5001/api/boperation';
      var response = await http.post(Uri.parse(infourl), body: body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        beoperationPostList =
            x.map((e) => BoperationformPost.fromJson(e)).toList();
        setState(() {
          beoperationPost = beoperationPostList;
          pals = [];
          energy = [];
          pals.add(beoperationPost![0].pals);
          energy.add(beoperationPost![0].energy);
        });
      }
    }
  }

  bool? sabtButton = true;

  Future<List<Barea>?> postform() async {
    setState(() {
      sabtButton = false;
    });
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    var body = json.encode({
      "editid": widget.editid,
      "packid": widget.packid,
      "opid": widget.id,
      "area": widget.select,
      "amount": amountPost,
      "Device": devicePost,
      "tip": tipPost,
      "handpis": int.parse(handpisPost.toString()),
      "moj": mojPost,
      "pals": int.parse(palsPost.toString()),
      "energy": int.parse(energyPost.toString()),
      "shot": int.parse(selectShat.toString()),
      "time": int.parse(selecttime.toString()),
    });
    print(body);
    if (token != null) {
      // String infourl = 'http://:1989/api/boperation';
      String infourl = 'http://128.65.186.187:1989/api/boperation';
      // String infourl = 'http://93.115.144.242:5001/api/boperation';
      var response = await http.post(Uri.parse(infourl), body: body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        if (x["message"] == "1") {
          setState(() {
            sabtButton = true;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Amalkard(),
          ));
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            duration: const Duration(seconds: 2),
            content: const Text(
              'عملکرد با موفقیت ثبت شد',
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
            'عملکرد ثبت نشد لطفا دوباره امتحان کنید',
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
