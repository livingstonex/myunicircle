import 'package:flutter/material.dart';
import 'package:MyUnicircle/Views/facial_two.dart';

class FacialOne extends StatefulWidget {
  @override
  _FacialOneState createState() => _FacialOneState();
}

class _FacialOneState extends State<FacialOne> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/splash_bg.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/asset-1.png', height: 120),
                        SizedBox(height: 50),
                        Text('Sign in facially',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(height: 150),
                        btnOne(),
                        btnTwo()
                      ])),
            ])));
  }

  Widget btnOne() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FacialTwo()));
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width * 0.55,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.purple),
            child: Center(
                child:
                    Text('Continue', style: TextStyle(color: Colors.white)))));
  }

  Widget btnTwo() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width * 0.55,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: Colors.purple),
            color: Colors.white),
        child: Center(
            child: Text('Skip', style: TextStyle(color: Colors.purple))));
  }
}
