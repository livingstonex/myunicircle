import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:MyUnicircle/Views/Login/login_screen.dart';
import 'package:MyUnicircle/Views/Welcome/welcome_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController pageController;
  double pageOffset = 0;
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page;
      });
      print(pageOffset.truncate());
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var absHeight = MediaQuery.of(context).size.height;
    var absWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: absHeight,
            width: absWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/on_bg.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            height: absHeight,
            width: absWidth,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 8,
                  child: PageView(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (int index) =>
                        currentPageNotifier.value = index,
                    children: <Widget>[
                      Page(
                        title: "Meet New People",
                        body:
                            "Increase your network by meeting new people daily",
                        imagePath: "assets/images/meet_new.png",
                        offset: pageOffset - 1,
                      ),
                      Page(
                        title: "Get Funded",
                        body:
                            "Interact with a group of experienced investors, all on our platform",
                        imagePath: "assets/images/get_funded.png",
                        offset: pageOffset - 2,
                      ),
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: pageOffset.truncate() == 1
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(),
                                    ),
                                  );
                                },
                          child: Text(
                            "Skip all",
                            style: TextStyle(
                              color: pageOffset.truncate() != 1
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                height: 13,
                                width: 13,
                                decoration: BoxDecoration(
                                  color: pageOffset == i
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        FlatButton(
                          onPressed: pageOffset != 1
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(),
                                    ),
                                  );
                                },
                          child: Text(
                            "Get started",
                            style: TextStyle(
                                color:
                                    pageOffset == 1 ? Colors.blue : Colors.grey,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ]));
  }
}

class Page extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;
  final double offset;

  Page({this.imagePath, this.title, this.body, this.offset});

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.09));
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
            height: 450.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
          child: Transform.translate(
            offset: Offset(-100 * gauss, 0),
            child: Opacity(
              opacity: 0.7,
              child: Text(body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
