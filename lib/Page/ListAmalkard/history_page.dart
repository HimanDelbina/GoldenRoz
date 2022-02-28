import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nima/Model/boperationhistory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  final String? name;
  final int? id;
  const HistoryPage({Key? key, this.name, this.id}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    getboperationhistory();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لیست جلسات" + " " + widget.name!.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 14.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.purpleAccent,
        ),
      ),
      body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: boperationhistory!.length != null
              ? ListView.builder(
                  itemCount: boperationhistory!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            boperationhistory![index].select =
                                !boperationhistory![index].select;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          // height: boperationhistory![index].select
                          //     ? myHeight * 0.4
                          //     : myHeight * 0.1,
                          width: myWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: boperationhistory![index].select
                                ? Colors.purple.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(boperationhistory![index].opname,
                                        style: TextStyle(
                                            fontWeight:
                                                boperationhistory![index].select
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                    Text(
                                        boperationhistory![index]
                                            .pack
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight:
                                                boperationhistory![index].select
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                    Text(
                                        boperationhistory![index]
                                            .shot
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight:
                                                boperationhistory![index].select
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                    Text(
                                        boperationhistory![index]
                                            .time
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight:
                                                boperationhistory![index].select
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                    Icon(
                                      boperationhistory![index].select
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 15,
                                      color: boperationhistory![index].select
                                          ? Colors.black
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      boperationhistory![index].optime,
                                      style: TextStyle(
                                          color:
                                              boperationhistory![index].select
                                                  ? Colors.black
                                                  : Colors.grey),
                                    ),
                                    Text(
                                      boperationhistory![index].opdate,
                                      style: TextStyle(
                                          color:
                                              boperationhistory![index].select
                                                  ? Colors.black
                                                  : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              boperationhistory![index].select
                                  ? Container(
                                      height: 300,
                                      child: ListView.builder(
                                        itemCount: boperationhistory![index]
                                            .details
                                            .length,
                                        itemBuilder: (context, f) {
                                          for (var item
                                              in boperationhistory![index]
                                                  .details) {
                                            detail!.add(item);
                                          }
                                          print(detail);
                                          return Column(
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "ناحیه :  ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                detail![f].area,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "تیپ پوستی :  "),
                                                              Text(detail![f]
                                                                  .tip
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "هندپیس :  "),
                                                              Text(detail![f]
                                                                  .handpis
                                                                  .toString()),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(detail![f]
                                                                  .device
                                                                  .toString() +
                                                              " / " +
                                                              detail![f]
                                                                  .moj
                                                                  .toString()),
                                                          Row(
                                                            children: [
                                                              Text("پالس :  "),
                                                              Text(detail![f]
                                                                  .pals
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("انرژی :  "),
                                                              Text(detail![f]
                                                                  .energy
                                                                  .toString()),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider()
                                            ],
                                          );
                                        },
                                      ))
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                      "سابقه ای برای مراجعه کننده در سیستم ثبت نشده است"))),
    );
  }

  List? boperationhistory = [];
  List? detail = [];
  var boperationhistoryList;
  var conbool = [];
  int? detailsLenght = 0;
  Future<List<Boperationhistory>?> getboperationhistory() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString('token');
    if (token != null) {
      String infourl =
          'http://128.65.186.187:1989/api/boperation/' + widget.id.toString();
      // String infourl =
      //     'http://93.115.144.242:5001/api/boperation/' + widget.id.toString();
      var response = await http.get(Uri.parse(infourl), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        boperationhistoryList =
            x.map((e) => Boperationhistory.fromJson(e)).toList();
        setState(() {
          boperationhistory = boperationhistoryList;
        });
        print(boperationhistory);
        print(boperationhistory!.length);
      }
    }
  }
}
