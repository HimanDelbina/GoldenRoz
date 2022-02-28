import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nima/Model/area_model.dart';
import 'package:nima/Model/barea_model.dart';
import 'package:nima/Model/pack_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'formsabt_page.dart';

class FirstFormSabt extends StatefulWidget {
  final String? name;
  final int? gender;
  final int? id;
  final int? editid;
  const FirstFormSabt({Key? key, this.gender, this.id, this.name, this.editid})
      : super(key: key);

  @override
  _FirstFormSabtState createState() => _FirstFormSabtState();
}

class _FirstFormSabtState extends State<FirstFormSabt> {
  String? selectShat;
  TextEditingController controllerselectShat = TextEditingController();
  String? selectTime;
  TextEditingController controllerselectTime = TextEditingController();
  @override
  void initState() {
    getbarea();
    getPack();
    super.initState();
  }

  int packSelect = 1;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: pack!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    onTap: () async {
                      reset();
                      setState(() {
                        packSelect = pack![index].id;
                      });
                      await getFullPack();
                      print(fullPack.toString());
                      var x = fullPack!.map((e) => e.areaId).toList();
                      print('object');
                      for (var i = 0; i < barea!.length; i++) {
                        if (x.contains(barea![i].id)) {
                          barea![i].selected = true;
                          //  selectItem.add(barea![index].id);
                        }
                      }
                      setState(() {
                        barea = barea;
                      });
                    },
                    child: Container(
                      height: myHeight * 0.1,
                      width: myWidth * 0.2,
                      decoration: BoxDecoration(
                          color: pack![index].id == packSelect
                              ? Colors.deepPurpleAccent
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        pack![index].title.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: pack![index].id == packSelect
                              ? Colors.white
                              : Colors.black,
                          fontWeight: pack![index].id == packSelect
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
              child: GridView.builder(
            itemCount: barea!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  // onTap: () {
                  //   setState(() {
                  //     itembool[index] = !itembool[index];
                  //   });
                  //   if (itembool[index] == true) {
                  //     selectItem.add(barea![index].id);
                  //   } else if (itembool[index] == false) {
                  //     selectItem.remove(barea![index].id);
                  //   }

                  //   print(selectItem);
                  // },
                  onTap: () {
                    setState(() {
                      barea![index].selected = !barea![index].selected;
                    });
                  },
                  child: Container(
                    height: myHeight * 0.1,
                    width: myWidth * 0.2,
                    decoration: BoxDecoration(
                        color: barea![index].selected == true
                            ? Colors.deepPurpleAccent
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      barea![index].area.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: barea![index].selected == true
                            ? Colors.white
                            : Colors.black,
                        fontWeight: barea![index].selected == true
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    )),
                  ),
                ),
              );
            },
          )),
          Container(
            height: myHeight * 0.1,
            width: myWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectItem = [];
                  });
                  selected();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormSabt(
                          select: selectItem,
                          gender: widget.gender,
                          id: widget.id,
                          name: widget.name,
                          packid: packSelect,
                          editid: widget.editid,
                        ),
                      ));
                },
                child: Container(
                  width: myWidth,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "مرحله بعد",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void reset() {
    for (var i = 0; i < barea!.length; i++) {
      barea![i].selected = false;
    }
  }

  void selected() {
    for (var i = 0; i < barea!.length; i++) {
      if (barea![i].selected == true) {
        selectItem.add(barea![i].id);
      }
    }
  }

  List<int> selectItem = [];
  var itembool = [];
  List selectedbareaItems = [];
  String? bareaselectedName;
  int? bareaselectedID;
  // List<String> mybareaString = [];
  List? barea = [];
  List? bareadetails = [];
  var bareaList;
  Future<List<Barea>?> getbarea() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl =
          'http://128.65.186.187:1989/api/barea/' + widget.gender.toString();
      // String infourl =
      //     'http://93.115.144.242:5001/api/barea/' + widget.gender.toString();
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        bareaList = x.map((e) => Barea.fromJson(e)).toList();
        setState(() {
          barea = bareaList;
          itembool = List.generate(barea!.length, (bool) => false);
        });
      }
    }
  }

  List? pack = [];
  var packList;
  Future<List<PackModel>?> getPack() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl = 'http://128.65.186.187:1989/api/boperationform/pack/' +
          widget.gender.toString();
      // String infourl = 'http://93.115.144.242:5001/api/boperationform/pack/' +
      //     widget.gender.toString();
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        packList = x.map((e) => PackModel.fromJson(e)).toList();
        setState(() {
          pack = packList;
        });
      }
    }
  }

  List<int>? indexSelect = [];
  List? fullPack = [];
  var fullPackList;
  Future<List<AreaModel>?> getFullPack() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl =
          'http://128.65.186.187:1989/api/boperationform/pack/det/' +
              packSelect.toString();
      // String infourl =
      // 'http://93.115.144.242:5001/api/boperationform/pack/det/' +
      //     packSelect.toString();
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        fullPackList = x.map((e) => AreaModel.fromJson(e)).toList();
        setState(() {
          fullPack = fullPackList;
        });
      }
    }
  }
}
