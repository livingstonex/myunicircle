import 'package:flutter/material.dart';
import 'package:MyUnicircle/Views/Welcome/components/background.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class VoiceRecognition extends StatefulWidget {
  @override
  _VoiceRecognitionState createState() => _VoiceRecognitionState();
}

class _VoiceRecognitionState extends State<VoiceRecognition> {
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
              iconOption(),
              SizedBox(height: 40),
              Text(
                "Voice Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Text('Tap the button to record your voice',
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
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(.5),
        ),
        child: Center(child: Icon(Icons.mic, color: Colors.red, size: 100)));
  }
}
