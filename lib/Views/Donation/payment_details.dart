import 'dart:convert';

import 'package:MyUnicircle/Views/Donation/payment_page.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../app_style_resources.dart';

class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {

  bool isloading = false;
  String type ='';

  @override
  Widget build(BuildContext context) {
    //print("This the curent user ---- $currentUser");

    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RoundedButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  text: "Donate",
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Payments()));
                  },
                )),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColorDark
                            ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sendIcon(),
                        SizedBox(height: 8),
                        Text('Fund A Project',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700)),

                      ],
                    )),
                SizedBox(height: 40),
                //infoBox(),
                //SizedBox(height: 40),


                FutureBuilder(
                  future: getProjects(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: isloading
                            ? Container(
                            height: MediaQuery.of(context).size.height * .8,
                            child: ListView(
                              children: <Widget>[
                                shimmerLoading(),
                                shimmerLoading(),
                                shimmerLoading(),
                              ],
                            ))
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.perm_scan_wifi,
                              size: 50,
                              color: appColorSmoke,
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  isloading = true;
                                });
                                getProjects();
                              },
                              color: appColorSmoke,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Error, try Again",
                                style: largeText(appColorBlack),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      var res_data = jsonDecode(snapshot.data);
                      if (res_data["message"]=="Success") {

                        var project_name = res_data["response"][0]['project_name'];
                        var project_type = res_data["response"][0]['project_type'];
                        var project_time = res_data["response"][0]['project_time'];


                        return infoBox2(project_name,project_type,project_time);


                      }
                    }

                    return Container(
                        height: MediaQuery.of(context).size.height * .8,
                        child: ListView(
                          children: <Widget>[
                            shimmerLoading(),
                            shimmerLoading(),
                            shimmerLoading(),
                          ],
                        ));
                  },
                ),


              ],
            ))));
  }




  Future<String> getProjects() async {

    try {
      http.Response response = await http.get(CURRENT_PROJECTS);
      print("Response  ---- " + response.body.toString());
      if (response.statusCode == 200) {

        return response.body;
      } else {
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      throw Exception(e);
    }
  }



  Widget shimmerLoading() {
    return Shimmer.fromColors(
        baseColor: appColorShade,
        highlightColor: Colors.white,
        period: Duration(seconds: 1, microseconds: 1),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: appColorShade, borderRadius: BorderRadius.circular(10)),
        ));
  }


  Widget sendIcon() {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(.8)),
        child: Center(
            child: Icon(FontAwesome.handshake_o,
                color: Theme.of(context).primaryColor, size: 45)));
  }

  Widget textField(String labelText, Widget prefixIcon) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Center(
            child: TextField(
                keyboardType: (labelText == 'Amount')
                    ? TextInputType.number
                    : TextInputType.text,
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    /*
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    */
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: prefixIcon))));
  }

//  Widget infoBox() {
//    return Container(
//        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(10),
//            color: Colors.white,
//            boxShadow: [
//              BoxShadow(
//                color: Colors.black26,
//                blurRadius: 10.0, // soften the shadow
//                spreadRadius: 0.5, //extend the shadow
//                offset: Offset(
//                  0.0, // Move to right 10  horizontally
//                  0.0, // Move to bottom 10 Vertically
//                ),
//              )
//            ]),
//        width: MediaQuery.of(context).size.width * 0.90,
//        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//          RichText(
//            text: TextSpan(
//                text: 'Funding Amount:',
//                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//                children: <TextSpan>[
//                  TextSpan(
//                    text: '     \$52',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.green,
//                        fontFamily: 'Poppins'),
//                  )
//                ]),
//          ),
//          SizedBox(height: 30),
//          RichText(
//            text: TextSpan(
//                text: 'Available Balance:',
//                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//                children: <TextSpan>[
//                  TextSpan(
//                    text: '     \$2000',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.green,
//                        fontFamily: 'Poppins'),
//                  )
//                ]),
//          ),
//          SizedBox(height: 30),
//          RichText(
//            text: TextSpan(
//                text: 'Project Type:',
//                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//                children: <TextSpan>[
//                  TextSpan(
//                    text: '     Agriculture',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black,
//                        fontFamily: 'Poppins'),
//                  )
//                ]),
//          ),
//          SizedBox(height: 30),
//          RichText(
//            text: TextSpan(
//                text: 'Weeks Left:',
//                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//                children: <TextSpan>[
//                  TextSpan(
//                    text: '     51',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black,
//                        fontFamily: 'Poppins'),
//                  )
//                ]),
//          ),
//        ]));
//  }



  Widget infoBox2(String project_name,String project_type,String project_time) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 0.5, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  0.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Text(project_name,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
                text: 'Funding Amount:',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: '     \N389',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Poppins'),
                  )
                ]),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
                text: 'Available Balance:',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: '     \N2,000',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Poppins'),
                  )
                ]),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
                text: 'Project Type:',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: '     $project_type',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  )
                ]),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
                text: 'Weeks Left:',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: '     $project_time weeks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  )
                ]),
          ),
        ]));
  }



}
