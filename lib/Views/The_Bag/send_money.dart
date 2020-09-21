import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              text: "Send",
              press: () {},
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
                    Text('Send Money',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700))
                  ],
                )),
            SizedBox(height: 40),
            textField('Account number',
                Icon(Icons.credit_card, color: Theme.of(context).primaryColor)),
            SizedBox(height: 20),
            textField(
                'Amount',
                Icon(FontAwesome.dollar,
                    color: Theme.of(context).primaryColor)),
          ],
        )));
  }

  Widget sendIcon() {
    return Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(.8)),
        child: Center(
            child: Icon(Ionicons.ios_send,
                color: Theme.of(context).primaryColor, size: 50)));
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
}
