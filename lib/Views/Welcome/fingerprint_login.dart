import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/Views/Welcome/components/background.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class FingerPrintLogin extends StatefulWidget {
  @override
  _FingerPrintLoginState createState() => _FingerPrintLoginState();
}

class _FingerPrintLoginState extends State<FingerPrintLogin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var absHeight = MediaQuery.of(context).size.height;
    var absWidth = MediaQuery.of(context).size.width;
    return Background(
      child: Column(children: [
        Container(
          height: absHeight * 0.20,
          width: absWidth,
        ),
        Container(
          alignment: Alignment.topCenter,
          height: absHeight * 0.80,
          width: absWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(MaterialIcons.fingerprint, size: 100, color: Colors.grey),
              SizedBox(height: 40),
              Text(
                "Fingerprint Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Text('Place your hand slowly on the fingerprint scanner',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              SizedBox(height: size.height * 0.10),
              RoundedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                text: "Validate",
                press: () {},
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget iconOption() {
    return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(.5),
        ),
        child: Center(child: Icon(Icons.mic, color: Colors.red, size: 100)));
  }
}
