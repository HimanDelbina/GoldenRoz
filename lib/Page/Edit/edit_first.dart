import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nima/Model/barea_model.dart';
import 'package:nima/Page/Edit/edit_second.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditFirstPage extends StatefulWidget {
  final int? gender;
  final int? id;
  final int? editid;
  var jalasat;
  EditFirstPage({Key? key, this.gender, this.id, this.editid, this.jalasat})
      : super(key: key);

  @override
  _EditFirstPageState createState() => _EditFirstPageState();
}

class _EditFirstPageState extends State<EditFirstPage> {
  String? selectShat;
  TextEditingController controllerselectShat = TextEditingController();
  String? selectTime;
  TextEditingController controllerselectTime = TextEditingController();
  @override
  void initState() {
    getbarea();
    super.initState();
  }

  int packSelect = 1;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
              itemCount: barea!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      // if (barea![index].selected == true) {
                      //   selectItem.add(barea![index].id);
                      // } else if (barea![index].selected == false) {
                      //   selectItem.remove(barea![index].id);
                      // }
                      // print(selectItem);
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectItem = [];
                    });
                    selected();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditSabt(
                            gender: widget.gender,
                            id: widget.id,
                            editid: widget.editid,
                            jalasatPass: widget.jalasat,
                            select: selectItem,
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
        });
        for (var i = 0; i < barea!.length; i++) {
          if (barea![i].area == widget.jalasat.area) {
            setState(() {
              barea![i].selected = !barea![i].selected;
              selectItem.add(barea![i].id);
            });
            print(barea![i].id);
          }
        }
      }
    }
  }
}
