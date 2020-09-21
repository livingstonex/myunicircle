import 'package:camera/camera.dart';
//import 'package:camera/new/src/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/Views/Welcome/components/background.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class FacialLogin extends StatefulWidget {
  @override
  _FacialLoginState createState() => _FacialLoginState();
}

class _FacialLoginState extends State<FacialLogin> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          // 2
          selectedCameraIdx = 1;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    // 3
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    // 4
    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return Container(
      height: 200,
      width: 200,
      // aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

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
              _cameraPreviewWidget(),
              SizedBox(height: 20),
              Text(
                "Facial Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Text(
                    'Look into the camera to scan your face. Avoid any facial expression',
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
