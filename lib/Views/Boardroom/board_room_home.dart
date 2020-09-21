import 'package:MyUnicircle/app_style_resources.dart';
import 'package:MyUnicircle/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/Views/Donation/payment_details.dart';

import 'newboardroom.dart';

class BoardRoom extends StatefulWidget {
  @override
  _BoardRoomState createState() => _BoardRoomState();
}

class _BoardRoomState extends State<BoardRoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/UploadPitch');
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              header(), SizedBox(height: 10),
              SizedBox(height: 15),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Visit The BoardRoom',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),


                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewboardRoom()));

                          },
                          child: Text(
                            'Visit',
                            style: largeText(Colors.white),
                          )),

                      Text('The Entreprenueral Hub',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          'Do you have a thrilling business idea which needs funding? Pitch your idea to a highly experienced audience of investors at MyUnicircle. The boardroom is a place for ambitiuos Entreprenuers make their dreams a reality.\nHit the button below to get started',
                          style: TextStyle(color: Colors.grey[600]))
                    ],
                  ))

              //  infoCard()
            ]))));
  }

  Widget header() {
    return Stack(children: [
      Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/donation_header.jpg'),
                  fit: BoxFit.cover))),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 250,
          width: MediaQuery.of(context).size.width,
          color: Colors.black45.withOpacity(.7),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pitch your ideas to\ntop investors',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center),
                // SizedBox(height: 10),
                //borderBtn()
              ])),
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
}
