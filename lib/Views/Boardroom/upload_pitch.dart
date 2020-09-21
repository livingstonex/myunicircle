import 'dart:async';
import 'dart:math';

import 'package:MyUnicircle/app_style_resources.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:flutter_icons/flutter_icons.dart';

class UploadPitch extends StatefulWidget {
  @override
  _UploadPitchState createState() => _UploadPitchState();
}

class _UploadPitchState extends State<UploadPitch> {


  final PageController _pageController = PageController(initialPage: 0);
  final int numPage = 3;
  int _currentPage = 0;
  String selectedItem;
  int _radioValue;
  TextEditingController bizDesc = new TextEditingController();
  TextEditingController bizName = new TextEditingController();
  TextEditingController bizEcoFriendly = new TextEditingController();
  TextEditingController bizRevFunction = new TextEditingController();
  TextEditingController bizRevenue = new TextEditingController();
  TextEditingController bizTeamProfile = new TextEditingController();

  String bizStage = '';
  String _timeAvailable ='';




  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          bizStage = "Idea";
          break;
        case 1:
          bizStage = "Product or service prototype";
          break;
        case 2:
          bizStage = "Established business";
          break;
      }
    });
  }

  startPitch() {
    loadingDialog();
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pitch Deck Submitted',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              content: Text(
                  'Your pitch has been submitted and is being reviewed by the board. An email will be sent to you stating the scheduled time for the presentation. Be prepared!',
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/Home');
                    },
                    child: Text('Proceed to Home',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)))
              ],
            );
          });
    });
  }

  dynamic loadingDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                backgroundColor: Colors.black54,
                children: [
                  Center(
                      child: Column(children: [
                    CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white)),
                    SizedBox(height: 10),
                    Text('Please wait...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ))
                  ]))
                ],
              ));
        });
  }

  int stage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      (_currentPage == numPage - 1)
                          ? uploadPitch()
                          : _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                    },
                    child: (_currentPage == numPage - 1)
                        ? Text(
                            'I Agree',
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            body: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50),
                                  Text('STAGE ONE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 35,
                                          color: Colors.blue[700])),
                                  SizedBox(height: 20),

                                  Text('Enter Business Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 10),
                                 textInput('Enter Here'),


                                  SizedBox(height: 20),
                                  Text('Select Business Category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5),
                                  dropDown(),
                                  SizedBox(height: 15),

                                  Text('1. Describe in 100 words how innovative is your business.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5,),
                                  bigTextInput2(bizDesc, "Describe"),

                                  SizedBox(height: 10,),


                                  Text('2. Is your product, service and packaging eco friendly, organic, and biodegradable. Kindly describe how eco friendly, organic and biodegradable your product is in 100 words.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5,),
                                  bigTextInput2(bizEcoFriendly, "Describe"),


//                                  SizedBox(height: 40),
//                                  textInput('Full name', Icons.person),
//                                  SizedBox(height: 30),
//                                  textInput('Area of Expertise', Icons.work),
//                                  SizedBox(height: 30),
//                                  Text('Is this your first business?',
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w600,
//                                          fontSize: 16)),
//                                  Row(children: [
//                                    Radio(
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    Text('Yes')
//                                  ]),
//                                  Row(children: [
//                                    Radio(
//                                      value: 1,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    Text('No')
//                                  ])


                                ]))
                      ])),
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50),
                                  Text('STAGE TWO',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 35,
                                          color: Colors.blue[700])),
                                  SizedBox(height: 20),


                                  Text('3. Who are your team and what are their functions?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5,),
                                  bigTextInput2(bizTeamProfile, "Document"),


                                  SizedBox(height: 30),
                                  Text('4. What is the Stage of the business',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Row(children: [
                                    Radio(
                                      value: 0,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('Idea')
                                  ]),
                                  Row(children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('Product or service prototype')
                                  ]),


                                  Row(children: [
                                    Radio(
                                      value: 2,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('Established business')
                                  ]),


                                  SizedBox(height: 5,),
                                  Text('5. Has this business generated revenue? State the revenue based on years of operation.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5,),
                                  bigTextInput2(bizRevenue, "Explain"),



//                                  SizedBox(height: 30),
//                                  Text('Do you have a business name?',
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w600,
//                                          fontSize: 16)),
//                                  Row(children: [
//                                    Radio(
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    Text('Yes')
//                                  ]),
//                                  Row(children: [
//                                    Radio(
//                                      value: 1,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    Text('No')
//                                  ]),
//                                  // SizedBox(height: 30),
//                                  textInput(
//                                      'If yes please profile an RC number',
//                                      Icons.receipt),
//                                  SizedBox(height: 30),
//                                  textInput(
//                                      'How much would you like for seed funding?',
//                                      Icons.monetization_on),
                                ]))
                      ])),
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50),
                                  Text('STAGE THREE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 35,
                                          color: Colors.blue[700])),
                                  SizedBox(height: 20),

                                  SizedBox(height: 5,),
                                  Text('5. What will you use this funding for when secured. Explain in 100 words.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 5,),
                                  bigTextInput2(bizRevFunction, "Explain"),



                                  SizedBox(height: 15,),

                                  Text('Note: We require 20% stake of the brand the entrepreneur is pitching on myunicircle which is default regardless of if myunicircle will be interested in funding the brand or not.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(height: 15,),


                                  _timeAvailable == ""
                                      ? FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {

                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2020, 1, 12),
                                            maxTime: DateTime(2050, 1, 12),
                                            theme: DatePickerTheme(
                                                headerColor: Colors.grey,
                                                backgroundColor: Colors.white,
                                                itemStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                            onChanged: (date) {
                                              //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                            },
                                            onConfirm: (date) {
                                              print('confirm $date');
                                              setState(() {
                                                _timeAvailable = date.toString();
                                              });
                                            },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Text(
                                        'Select Pitch Time',
                                        style: largeText(Colors.white),
                                      ))
                                      : Text(
                                    "Pitch Time: $_timeAvailable",
                                    style: largeTextBold(Colors.black),
                                    textAlign: TextAlign.start,
                                  ),




//                                  Text('Kindly upload a copy of your pitch',
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w600,
//                                          fontSize: 16)),
//                                  SizedBox(height: 40),
//                                  Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                      children: [
//                                        uploadBox(),
//                                      ]),
//                                  SizedBox(height: 30),
//                                  bigTextInput()


                                ]))
                      ])),
                ])));
  }

  Widget textInput(String hintText) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 7),
//            child: Icon(icon, color: Colors.grey),
//          ),
          Expanded(
              child: TextField(
                controller: bizName,
                  decoration: InputDecoration.collapsed(
                      hintStyle: TextStyle(fontSize: 12), hintText: hintText)))
        ],
      ),
    );
  }


  void uploadPitch()async{



    Random random = new Random();
    int randNum =
        random.nextInt(100000) + 10000;
    String code = "$randNum";
    var seconds = DateTime.now().second;
    String pitchC = "$code $seconds";


    String userId =currentUser.value.id;
    loadingDialog();
    var data = {
      "userId":"$userId",
      "bizDesc":bizDesc.text,
      "bizEcoFriendly":bizEcoFriendly.text,
      "bizRevFunction":bizRevFunction.text,
      "bizRevenue":bizRevenue.text,
      "bizTeamProfile":bizTeamProfile.text,
      "bizStage":bizStage,
      "bizName":bizName.text,
      "bizCategory":selectedItem,
      "pitchTime":_timeAvailable,
      "pitchCode":pitchC

    };

    try {
      http.Response response = await http.post(INSERT_PROJECTS, body: data);
      if (response.statusCode == 200) {

        print(response.body);
        Navigator.pop(context);
        Navigator.pop(context);


      } else {

      }
    }catch(e){
      Navigator.pop(context);
      throw Exception(e);
    }

  }


//
//  Widget bigTextInput() {
//    return Container(
//        height: 120,
//        width: MediaQuery.of(context).size.width,
//        // margin: EdgeInsets.symmetric(horizontal: 20),
//        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//        decoration: BoxDecoration(
//            color: Colors.transparent,
//            border: Border.all(
//              color: Colors.grey,
//            ),
//            borderRadius: BorderRadius.circular(4)),
//        child: Expanded(
//            child: TextField(
//                maxLines: 3,
//                decoration: InputDecoration.collapsed(
//                    hintStyle: TextStyle(fontSize: 12),
//                    hintText: 'Anything else you\'d like us to know?'))));
//  }






  Widget bigTextInput2(TextEditingController controller,String Hint) {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Expanded(
            child: TextField(
                maxLines: 3,
                controller: controller,
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(fontSize: 12),
                    hintText: Hint))));
  }

  Widget dropDown() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      //margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 20),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).focusColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration.collapsed(hintText: ''),
          isExpanded: true,
          iconEnabledColor: Colors.grey,
          value: selectedItem,
          validator: (String newValue) {
            if (newValue == null) {
              return 'Please select a network';
            }
            return null;
          },
          hint: Text(
            'Category',
            style: Theme.of(context).textTheme.subhead,
          ),
          style: TextStyle(
            color: Color(0xff02499B),
          ),
          onChanged: (String newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
          items: <String>[
            'Fintech',
            'Agro Industry',
            'Cosmetics',
            'Mining',
            'Hardware',
            'Software technology',
            'Artificial Intelligence',
          ].map<DropdownMenuItem<String>>((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child:
                  new Text(value, style: Theme.of(context).textTheme.subhead),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget uploadBox() {
    return Container(
        height: 170,
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(AntDesign.addfile, size: 40, color: Colors.grey),
          SizedBox(height: 10),
          Text('.pdf, .docx, .pptx, .mp4',
              style: TextStyle(color: Colors.grey, fontSize: 12))
        ])));
  }
}
