import 'package:flutter/material.dart';
import 'package:nima/Page/login_page.dart';
import 'package:nima/Provider/page_bloc.dart';
import 'package:provider/provider.dart';

class PageShow extends StatefulWidget {
  const PageShow({Key? key}) : super(key: key);

  @override
  _PageShowState createState() => _PageShowState();
}

class _PageShowState extends State<PageShow>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Color>? animationColor;
  Animation<double>? _animation;
  Animation<double>? _animation2;
  bool conActive = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.decelerate));
    _animation2 = Tween<double>(begin: 1.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.bounceIn));

    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController!.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final PageBloc page = Provider.of<PageBloc>(context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: page.pageShow),
            SizedBox(
              height: myHeight * 0.07,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _animationController!.forward();
                        // page.exit();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScaleTransition(
                            scale: page.pageIndex == 4
                                ? _animation!
                                : _animation2!,
                            child: Image.asset(
                              page.pageIndex == 4
                                  ? "assets/icon/navbarBold/Logout.png"
                                  : "assets/icon/navbarBold/Logout.png",
                              height: page.pageIndex == 4 ? 30.0 : 25.0,
                              color: page.pageIndex == 4
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          CircleAvatar(
                            radius: 3.0,
                            backgroundColor: page.pageIndex == 4
                                ? Colors.black
                                : Colors.grey.withOpacity(0.1),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _animationController!.forward();
                        page.history();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScaleTransition(
                            scale: page.pageIndex == 1
                                ? _animation!
                                : _animation2!,
                            child: Image.asset(
                              page.pageIndex == 1
                                  ? "assets/icon/navbarBold/Paper.png"
                                  : "assets/icon/navbarLight/Paper.png",
                              height: page.pageIndex == 1 ? 30.0 : 25.0,
                              color: page.pageIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          CircleAvatar(
                            radius: 3.0,
                            backgroundColor: page.pageIndex == 1
                                ? Colors.black
                                : Colors.grey.withOpacity(0.1),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          _animationController!.forward();
                          page.home();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ScaleTransition(
                              scale: page.pageIndex == 0
                                  ? _animation!
                                  : _animation2!,
                              child: Image.asset(
                                page.pageIndex == 0
                                    ? "assets/icon/navbarBold/Home.png"
                                    : "assets/icon/navbarLight/Home.png",
                                color: page.pageIndex == 0
                                    ? Colors.black
                                    : Colors.grey,
                                height: page.pageIndex == 0 ? 30.0 : 25.0,
                              ),
                            ),
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: page.pageIndex == 0
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.1),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          _animationController!.forward();
                          page.profile();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ScaleTransition(
                              scale: page.pageIndex == 2
                                  ? _animation!
                                  : _animation2!,
                              child: Image.asset(
                                page.pageIndex == 2
                                    ? "assets/icon/navbarBold/Profile.png"
                                    : "assets/icon/navbarLight/Profile.png",
                                color: page.pageIndex == 2
                                    ? Colors.black
                                    : Colors.grey,
                                height: page.pageIndex == 2 ? 30.0 : 25.0,
                              ),
                            ),
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: page.pageIndex == 2
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.1),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
