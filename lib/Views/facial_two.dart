import 'package:flutter/material.dart';

class FacialTwo extends StatefulWidget {
  @override
  _FacialTwoState createState() => _FacialTwoState();
}

class _FacialTwoState extends State<FacialTwo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.purple),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/facials.png', height: 170),
                      SizedBox(height: 150),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Keep your face still until the face scan completes',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 50),
                      btnOne(),
                    ]))));
  }

  Widget btnOne() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width * 0.55,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.purple),
        child:
            Center(child: Text('Done', style: TextStyle(color: Colors.white))));
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
