import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/Views/Donation/payment_details.dart';

class DonationLanding extends StatefulWidget {
  @override
  _DonationLandingState createState() => _DonationLandingState();
}

class _DonationLandingState extends State<DonationLanding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: donateBtn()),
            body: SingleChildScrollView(
                child: Column(children: [
              header(),
              SizedBox(height: 10),
              infoTile(),
              SizedBox(height: 15),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fund A Project',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          'The 52 weeks donation challenge is a platform where users can fund a developmental project for pure philantropical reasons. These projects includes roads, Covid-19 support, Healthcare and so on.',
                          style: TextStyle(color: Colors.grey[600]))
                    ],
                  ))

              //  infoCard()
            ]))));
  }

  Widget chatIcon() {
    return Stack(children: [
      IconButton(
          icon: Icon(Ionicons.ios_chatbubbles),
          onPressed: () {
            Navigator.of(context).pushNamed('/ChatHome');
          }),
      Positioned(top: 10, right: 1, child: indicator('5'))
    ]);
  }

  Widget indicator(String message) {
    return Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500))));
  }

  Widget header() {
    return Stack(children: [
      Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/donation_header.jpg'),
                  fit: BoxFit.cover))),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 220,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColorDark.withOpacity(.6),
        child: Text('52 Weeks \nDonation Challenge',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center),
      ),
    ]);
  }

  Widget borderBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaymentDetails()));
        },
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 0.5, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      0.0, // Move to bottom 10 Vertically
                    ),
                  )
                ]),
            child: Center(
                child:
                    Text('Start now', style: TextStyle(color: Colors.white)))));
  }

  Widget donateBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaymentDetails()));
        },
        child: Container(
            alignment: Alignment.center,
            height: 45,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColorDark
                ],
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text('Start Donating',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))));
  }

  Widget verticalDivider() {
    return Container(
      // height: 80,
      width: 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
    );
  }

  Widget infoTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.only(left: 15, bottom: 5),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            height: 130,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Colors.purple,
              /*
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark
                ],
              ),
              */
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 0.5, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/calendar.png', height: 50),
                  Text('Week 38',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                ])),
        Container(
            margin: EdgeInsets.only(right: 15, bottom: 5),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            height: 130,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              /*
              gradient: LinearGradient(
                colors: [Theme.of(context).canvasColor, Colors.orange],
              ),
              */
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 0.5, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/money_2.png', height: 50),
                  Text('\$38',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                ]))
      ],
    );
  }
}
