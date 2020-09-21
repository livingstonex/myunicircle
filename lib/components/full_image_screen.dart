import 'dart:ui';
import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  final String image;

  const FullImage({Key key, this.image}) : super(key: key);
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${widget.image}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    child: Image.network('${widget.image}'),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            makeLike(),
                            Transform.translate(
                                offset: Offset(-5, 0), child: makeLove()),
                            SizedBox(width: 5),
                            Text('2.5k',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))
                          ]),
                          Text('400 commments',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13))
                        ]),
                  ),
                ],
              ),
            ),
          )),
        ))
      ],
    ));
  }

  Widget makeLike() {
    return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
        child:
            Center(child: Icon(Icons.thumb_up, color: Colors.white, size: 12)));
  }

  Widget makeLove() {
    return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
        child:
            Center(child: Icon(Icons.favorite, color: Colors.white, size: 12)));
  }
}
