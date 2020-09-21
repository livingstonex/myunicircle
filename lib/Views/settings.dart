import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.purple,
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
                icon: Icon(Icons.mic, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.video_call, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.call, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              leading: photoWrap(),
              title: Text('Jameson Dunn',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
              subtitle: Text('jameson@gmail.com',
                  style: TextStyle(
                      //fontWeight:FontWeight.w600,
                      fontSize: 14)),
            )
          ],
        )));
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
        height: 18,
        width: 18,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            color: color,
            borderRadius: BorderRadius.circular(25)));
  }

  Widget infoBox() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Row(children: [
          photoWrap(),
        ])));
  }

  Widget photoWrap() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.purple,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/sophia.jpg'),
      ),
    );
  }
}
