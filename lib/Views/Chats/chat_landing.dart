import 'package:flutter/material.dart';
import 'package:MyUnicircle/Widgets/header_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/Controllers/chat_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatLanding extends StatefulWidget {
  @override
  _ChatLandingState createState() => _ChatLandingState();
}

class _ChatLandingState extends StateMVC<ChatLanding>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  ChatController _con;

  _ChatLandingState() : super(ChatController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.fetchAllUsers();
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
                height: 60,
                child: TabBar(
                  indicatorColor: Colors.purple,
                  controller: _tabController,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.purple,
                  tabs: [
                    new Tab(icon: Text('Messages')),
                    new Tab(
                      icon: new Text('Chats'),
                    ),
                  ],
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: Icon(
                  Ionicons.ios_chatbubbles,
                  color: Colors.white,
                )),
            body: SingleChildScrollView(
                child: Column(children: [
              HeaderWidget(),
              SizedBox(height: 5),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [messageTab(), callsTab()],
                  controller: _tabController,
                ),
              ),
              SizedBox(height: 10),
            ]))));
  }

  Widget chatTile(String image, String name, String subtitle, String time) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/ChatSingle');
      },
      leading: leadingImage(image, Colors.green),
      title: Text(name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
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
        height: 18,
        width: 18,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            color: color,
            borderRadius: BorderRadius.circular(25)));
  }

  Widget callsTab() {
    return Container();
  }

  Widget messageTab() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Messages',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  SizedBox(height: 10),
                  Text('You have 2 new messages', style: TextStyle())
                ],
              )),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                children: [
                  chatTile(
                      'assets/images/sophia.jpg',
                      'Mike Tyson',
                      'Hey, I stopped by your place yesterday, but you were not home!',
                      'Now'),
                  Divider(),
                  chatTile('assets/images/james.jpg', 'Tory Crimson',
                      'Hello Blair, i\'m Tory.', 'Now'),
                  Divider(),
                  chatTile(
                      'assets/images/greg.jpg',
                      'Gregory Kings',
                      'We have no choice but to use Angular 8 to build the CMS',
                      'Now'),
                  Divider(),
                  chatTile('assets/images/john.jpg', 'John Floyd',
                      'Where\'re you??', '11:00pm'),
                  Divider(),
                  chatTile('assets/images/sam.jpg', 'Suzie Anne',
                      'Hey, whats up?', '7:10am'),
                  Divider(),
                  chatTile('assets/images/olivia.jpg', 'Olivia Johnson',
                      'We just recieved his mail.', '8:20am'),
                  Divider(),
                  chatTile('assets/images/steven.jpg', 'Steve Harvey',
                      'My show starts by 12pm', '10:00am'),
                ],
              )),
        ]));
  }

  Widget searchBox() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.grey[200]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: 'Search messages'))),
          Icon(Icons.search, color: Colors.purple)
        ]));
  }
}
