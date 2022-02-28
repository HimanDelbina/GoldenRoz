import 'package:flutter/cupertino.dart';
import 'package:nima/Page/history_page.dart';
import 'package:nima/Page/home_page.dart';
import 'package:nima/Page/login_page.dart';
import 'package:nima/Page/profile_page.dart';

class PageBloc extends ChangeNotifier {
  Widget _pageShow = const Home();
  int _pageIndex = 0;

  Widget get pageShow => _pageShow;
  int get pageIndex => _pageIndex;

  set counter(var val) {
    _pageShow = val;
    notifyListeners();
  }

  set counterIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  home() {
    _pageShow = const Home();
    _pageIndex = 0;
    notifyListeners();
  }

  profile() {
    _pageShow = const Profile();
    _pageIndex = 2;
    notifyListeners();
  }

  history() {
    _pageShow = const History();
    _pageIndex = 1;
    notifyListeners();
  }
  exit() {
    _pageShow = const LoginPage();
    _pageIndex = 4;
    notifyListeners();
  }
}
