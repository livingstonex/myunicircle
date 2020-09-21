import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/boardroom_page.dart';

class BoardRoom extends StatefulWidget {
  @override
  _BoardRoomState createState() => _BoardRoomState();
}

class _BoardRoomState extends State<BoardRoom>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple,
          elevation: 0,
          actions: [
            chatIcon(),
            IconButton(icon: Icon(Icons.person), onPressed: () {}),
          ]),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Project Fund',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.purple,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Agriculture',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Forex',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Startups',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                )
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                CookiePage(),
                CookiePage(),
                CookiePage(),
              ]))
        ],
      ),
    );
  }

  Widget chatIcon() {
    return Stack(children: [
      IconButton(
          icon: Icon(Ionicons.ios_chatbubbles),
          onPressed: () {
            Navigator.of(context).pushNamed('/ChatHome');
          }),
      Positioned(top: 10, right: 1, child: indicator('5'))
    ]);
  }

  Widget indicator(String message) {
    return Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500))));
  }
}
