import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lottie/lottie.dart';
import 'package:nima/Page/home_page.dart';
import 'package:nima/Page/page_show.dart';
import 'package:nima/Provider/check_internet.dart';
import 'package:nima/Static/static_file.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'no_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  final formkey = GlobalKey<FormState>();
  String? name;
  TextEditingController controllerName = TextEditingController();
  String? password;
  TextEditingController controllerPassword = TextEditingController();

  bool validAndSaveUser() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validAndSubmitUser() {
    if (validAndSaveUser()) {
      formkey.currentState!.reset();
      loginUser();
    }
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
        exit(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("خروج"),
      content: const Text("آیا مطمئن هستید که می خواهید از برنامه خارج شوید"),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return true;
      },
      child: Form(
        key: formkey,
        child: Scaffold(
            body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(200.0))),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(200.0))),
                      ),
                    ],
                  ),
                ],
              ),
              login(),
            ],
          ),
        )),
      ),
    );
  }

  Widget login() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                          child: Text(
                        "کلینیک زیبایی گلدن رُز",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                          child: Text(
                        "دکتر رحمان پناه",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontSize: 16.0),
                      )),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: TextFormField(
                          onSaved: (value) => name = value,
                          controller: controllerName,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.person),
                            label: const Text("نام کاربری"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: TextFormField(
                          onSaved: (value) => password = value,
                          controller: controllerPassword,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.password),
                            label: const Text("رمز ورود"),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Center(
                                child: Text(
                              "نسخه آموزشی",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 16.0),
                            )),
                          ],
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: myHeight * 0.1,
                    width: myWidth,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: validAndSubmitUser,
                          child: Container(
                            height: myHeight * 0.08,
                            width: myWidth,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                              child: Text(
                                "ورود",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const NoInternet();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  var token;
  Future loginUser() async {
    var body = jsonEncode({
      "Username": name,
      "password": password,
    });
    const infourl = 'http://128.65.186.187:1989/api/auth';
    // const infourl = 'http://93.115.144.242:5001/api/auth';
    var response = await http.post(Uri.parse(infourl), body: body, headers: {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final SharedPreferences prefsUser = await SharedPreferences.getInstance();
      Map<String, dynamic> result = json.decode(response.body);
      if (result["token"] != null) {
        prefsUser.setString('token', result["token"]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PageShow(),
            ));
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          duration: const Duration(seconds: 2),
          content: const Text(
            'نام کاربری یا رمز عبور اشتباه است',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Vazir",
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // final SharedPreferences pref = await SharedPreferences.getInstance();
      // token = pref.getString("token") ?? "";
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          'نام کاربری یا رمز عبور اشتباه است',
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
