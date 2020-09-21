import 'package:flutter/material.dart';

class IncomingCall extends StatefulWidget {
  @override
  _IncomingCallState createState() => _IncomingCallState();
}

class _IncomingCallState extends State<IncomingCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark
          ], stops: [
            0.1,
            0.9
          ])),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                userBox(),
                SizedBox(height: 20),
                Text('Janet Fowler',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25)),
                SizedBox(height: 20),
                Text('Calling...',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                SizedBox(height: 50),
                callOptions()
              ]))),
    );
  }

  Widget userBox() {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 10.0, // soften the shadow
          spreadRadius: 1, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            0.0, // Move to bottom 10 Vertically
          ),
        )
      ]),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/sophia.jpg'),
        ),
      ),
    );
  }

  Widget callOptions() {
    return Container(
        width: 150,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconOption(Icons.call, Colors.green),
              iconOption(Icons.call_end, Colors.red)
            ]));
  }

  Widget iconOption(IconData icon, Color color) {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(child: Icon(icon, color: Colors.white)));
  }
}
