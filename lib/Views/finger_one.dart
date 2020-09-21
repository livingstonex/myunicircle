import 'package:flutter/material.dart';
import 'package:MyUnicircle/Views/facial_two.dart';

class FingerPrintOne extends StatefulWidget {
  @override
  _FingerPrintOneState createState() => _FingerPrintOneState();
}

class _FingerPrintOneState extends State<FingerPrintOne> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            Text(
                              'Place your finger',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            Text(
                              'As shown by the picture, please place your finger on the sensor to scan fingerprint',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ])),
                      SizedBox(height: 50),
                      Text('Sign in facially',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18)),
                      SizedBox(height: 150),
                      btnOne(),
                      btnTwo()
                    ]))));
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
