import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:MyUnicircle/Views/Chats/incoming_call.dart';

class MainChat extends StatefulWidget {
  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  TextEditingController textEditingController = TextEditingController();
  bool isWriting = false;

  setWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              titleSpacing: 0,
              elevation: 0.5,
              automaticallyImplyLeading: true,
              title: Row(children: [
                leadingImage('assets/images/sophia.jpg', Colors.green),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Blair Dota',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                    SizedBox(height: 5),
                    Text('online',
                        style: TextStyle(
                            //fontWeight:FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white))
                  ],
                )
              ]),
              actions: [
                IconButton(
                  icon: Icon(Icons.video_call, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IncomingCall()));
                  },
                ),
              ],
            ),
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Flexible(
                    child: ListView(
                      // shrinkWrap: true,
                      children: [
                        Bubble(
                          margin: BubbleEdges.only(top: 20),
                          alignment: Alignment.topRight,
                          nip: BubbleNip.rightTop,
                          color: Color(0xFFff8abc),
                          child: Text(
                            'Hello, how are you?!',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 20),
                          alignment: Alignment.topLeft,
                          nip: BubbleNip.leftTop,
                          //color: Color(0xFFff8abc),
                          child: Text('I\'m fine. You?',
                              textAlign: TextAlign.left),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 20),
                          alignment: Alignment.topRight,
                          nip: BubbleNip.rightTop,
                          color: Color(0xFFff8abc),
                          child: Text(
                              'We\'re all doing well. It\'s been a while since we had a chat. You haven\'t been attending classes. Any problem?',
                              textAlign: TextAlign.right),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 20),
                          alignment: Alignment.topLeft,
                          nip: BubbleNip.leftTop,
                          // color: Color(0xFFff8abc),
                          child: Text(
                              'Nope. Just had a slight financial issue. I\'m good now.',
                              textAlign: TextAlign.left),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 20),
                          alignment: Alignment.topRight,
                          nip: BubbleNip.rightTop,
                          color: Color(0xFFff8abc),
                          child: Text('Okay then.It\'s nice hearing from you.',
                              textAlign: TextAlign.right),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 3),
                          alignment: Alignment.topRight,
                          color: Color(0xFFff8abc),
                          child: Text('Thanks alot for reaching out',
                              textAlign: TextAlign.right),
                        )
                      ],
                    ),
                  ),
                  chatControls()
                ],
              ))),
    );
  }

  Widget leadingImage(String image, Color color) {
    return Stack(children: [
      ClipOval(
        child: Image.asset(image, height: 50),
      ),
      onlineIndicator(color)
    ]);
  }

  Widget onlineIndicator(Color color) {
    return Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            color: color,
            borderRadius: BorderRadius.circular(25)));
  }

  Widget chatControls() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
                child: TextField(
              controller: textEditingController,
              style: TextStyle(color: Colors.white),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    color: Colors.black87,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide.none),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  filled: true,
                  fillColor: Colors.grey[300],
                  suffixIcon: IconButton(
                    icon: Icon(Icons.face, color: Colors.white),
                    onPressed: () {},
                  )),
            )),
            isWriting
                ? SizedBox.shrink()
                : IconButton(icon: Icon(Icons.mic), onPressed: () {}),
            isWriting
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.purple, shape: BoxShape.circle),
                    child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white, size: 15),
                        onPressed: () {}),
                  )
                : Container()
          ],
        ));
  }
}
