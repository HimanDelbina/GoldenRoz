import 'package:flutter/material.dart';
import 'package:nima/Page/home_page.dart';
import 'package:nima/Provider/check_internet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Page/login_page.dart';
import 'Page/page_show.dart';
import 'Page/splash_page.dart';
import 'Provider/page_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider<PageBloc>.value(
          value: PageBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Vazir"),
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [const Locale('fa', 'IR')],
        // home: const Splash(),
        home: const LoginPage(),
      ),
    );
  }
}
