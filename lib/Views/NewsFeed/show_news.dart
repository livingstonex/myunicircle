import 'package:MyUnicircle/Views/Boardroom/board_room_home.dart';
import 'package:MyUnicircle/Views/Donation/landing.dart';
import 'package:MyUnicircle/Views/NewsFeed/news_widget.dart';
import 'package:MyUnicircle/Views/Settings/settings.dart';
import 'package:MyUnicircle/Views/The_Bag/landing.dart';
import 'package:MyUnicircle/enum/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:MyUnicircle/resources/firebase_methods.dart' as firebaseRepo;

class ShowNews extends StatefulWidget {
  @override
  _ShowNewsState createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print(currentUser.value);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      firebaseRepo.setUserState(
          userId: currentUser.value.id, userState: UserState.Online);
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    String currentuserId = currentUser.value.id;

    switch (state) {
      case AppLifecycleState.resumed:
        currentuserId != null
            ? firebaseRepo.setUserState(
                userId: currentUser.value.id, userState: UserState.Online)
            : print('resume state');
        break;
      case AppLifecycleState.inactive:
        currentuserId != null
            ? firebaseRepo.setUserState(
                userId: currentUser.value.id, userState: UserState.Offline)
            : print('offline state');
        break;
      case AppLifecycleState.paused:
        currentuserId != null
            ? firebaseRepo.setUserState(
                userId: currentUser.value.id, userState: UserState.Waiting)
            : print('paused state');
        break;
      case AppLifecycleState.detached:
        currentuserId != null
            ? firebaseRepo.setUserState(
                userId: currentUser.value.id, userState: UserState.Offline)
            : print('detached state');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.grey[800],
            tabs: [
              Tab(icon: Icon(FontAwesome.feed)),
              Tab(icon: Icon(FontAwesome.handshake_o)),
              Tab(icon: Icon(FontAwesome.send_o)),
              Tab(icon: Icon(MaterialCommunityIcons.google_classroom)),
              Tab(icon: Icon(Icons.menu)),
            ],
          ),
          title: Image.asset('assets/images/logo_cut.png', height: 40),
          actions: [
            IconButton(
                icon: Icon(
                  Ionicons.ios_chatbubbles,
                  color: Colors.grey[500],
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ChatList');
                }),
            IconButton(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.grey[500],
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SearchPage');
                }),
            IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[500],
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/CreatePost');
                }),
          ],
        ),
        body: TabBarView(
          children: [
            NewsWidget(),
            DonationLanding(),
            TheBagComponent(),
            BoardRoom(),
            Settings(),
          ],
        ),
      ),
    ));

    /*Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              //height: 130,
              padding: EdgeInsets.only(left: 20, right: 20, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logo_cut.png', height: 40),
                  Row(children: [
                    /*
                    Expanded(
                      
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200]),
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Search",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.grey))))),*/
                    //SizedBox(height: 20),
                    Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.sort,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    )
                  ])
                ],
              )),
          SizedBox(height: 15),
          Divider(),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.videocam, color: Colors.red),
                      SizedBox(width: 3),
                      Text('Go Live',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))
                    ]),
                    Text('|', style: TextStyle(color: Colors.grey)),
                    Row(children: [
                      Icon(Icons.photo_album, color: Colors.green),
                      SizedBox(width: 3),
                      Text('Post',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))
                    ])
                  ])),
          Divider(),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Stories",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2)),
                                Text("See Archives")
                              ]),
                        ),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 180,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                makeStory(
                                    storyImage: 'assets/images/paint1.jpg',
                                    userImage: 'assets/images/steven.jpg',
                                    userName: 'Steven Kings'),
                                makeStory(
                                    storyImage: 'assets/images/paint2.jpg',
                                    userImage: 'assets/images/sam.jpg',
                                    userName: 'Lindy Rayton'),
                                makeStory(
                                    storyImage: 'assets/images/paint3.jpg',
                                    userImage: 'assets/images/olivia.jpg',
                                    userName: 'Olivia Reynolds')
                              ],
                            )),
                        SizedBox(height: 40),
                        makeFeed(
                            userName: 'Olivia Anderson',
                            userImage: 'assets/images/olivia.jpg',
                            feedTime: 'just now',
                            feedImage: 'assets/images/paint1.jpg',
                            feedText:
                                'This is a wonderful work of art. Truly a masterpiece in the design!'),
                        makeFeed(
                            userName: 'Charity Benson',
                            userImage: 'assets/images/sam.jpg',
                            feedTime: '2 hr ago',
                            feedImage: 'assets/images/paint2.jpg',
                            feedText:
                                'Art in its best form. This touches my soul')
                      ])))
        ]));*/
  }
}
