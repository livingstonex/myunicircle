import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:MyUnicircle/Views/Project_fund/widgets/custom_button.dart';
import 'package:MyUnicircle/Views/Project_fund/core/consts.dart';
import 'package:MyUnicircle/Views/Project_fund/core/flutter_icons.dart';
import 'package:MyUnicircle/Views/Project_fund/pages/statistics_page.dart';
import 'package:MyUnicircle/Views/Project_fund/widgets/custom_appbar_widget.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
          title:
              Text('Covid 19 Tracker', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/cell.png",
                width: 160,
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                text: "Covid 19 ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: "Tracker",
                    style: TextStyle(
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomButton(
            msg: "Start Tracking",
          )
        ])));
  }
}
