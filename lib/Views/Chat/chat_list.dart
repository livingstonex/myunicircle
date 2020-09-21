import 'package:MyUnicircle/Controllers/chat_controller.dart';
import 'package:MyUnicircle/Models/friend_model.dart';
import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/components/chat_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/resources/user_repository.dart' as userRepo;
import 'package:MyUnicircle/resources/firebase_methods.dart' as firebaseRepo;

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends StateMVC<ChatList> {
  ChatController _con;

  _ChatListState() : super(ChatController()) {
    _con = controller;
  }

  @override
  void initState() {
    //_con.fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/SearchPage');
            },
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Ionicons.ios_chatbubbles,
              color: Colors.white,
            )),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).accentColor,
          titleSpacing: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SearchPage');
                }),
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  print('more');
                })
          ],
          bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              tabs: [
                Tab(icon: Icon(Entypo.chat)),
                Tab(icon: Icon(Icons.group)),
              ]),
          title: Text('Chats',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: TabBarView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: firebaseRepo.fetchFriendsList(
                        userId: userRepo.currentUser.value.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.docs);
                        var docList = snapshot.data.docs;
                        if (docList.isEmpty) {
                          print('list is empty');
                          return Container(
                            padding: EdgeInsets.all(30),
                            alignment: Alignment.topCenter,
                            child: Column(children: [
                              Text(
                                'You currently do not have any active chat seession. Click on the button below to start a chat',
                                style: TextStyle(color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          );
                        }
                        return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: docList.length,
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              FriendModel _friend =
                                  FriendModel.fromMap(docList[index].data());

                              return FutureBuilder<User>(
                                  future: _con.findUserById(_friend.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ChatItemWidget(
                                        receiver: snapshot.data,
                                        profileImage: snapshot.data.image,
                                        hasNew: true,
                                      );
                                    } else if (snapshot.hasError) {
                                      print('snapshot.error');
                                      print(snapshot.error);
                                    }
                                    return Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text('Loading...'));
                                  });
                            });
                      }

                      return Center(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator()));
                    })),
            Tab(icon: Icon(FontAwesome.handshake_o)),
          ],
        ),
      ),
    ));
  }
}

class LastMessage extends StatelessWidget {
  final stream;

  const LastMessage({Key key, this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var docList = snapshot.data.docs;
            if (docList.isNotEmpty) {
              MessageModel message = MessageModel.fromMap(docList.last.data());
              return Text(message.message,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 13));
            }

            return Text('No message',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: 13));
          }

          return Text('..',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 13));
        });
  }
}

// receiver: _con.usersList[index],
// title: '${_con.usersList[index].username}',
// profileImage: '${_con.usersList[index].image}',
// messageClip:
//     'Hello, my name is eminiem and i rap very fast',
// hasNew: false,
// time: '10am'

/*
ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    ChatItemWidget(
                        title: 'Jennifer Lopez',
                        profileImage:
                            'https://image.cnbcfm.com/api/v1/image/104376860-GettyImages-647177884.jpg?v=1574102788&w=1400&h=950',
                        messageClip:
                            'Hi babe, i have a huge crush on you. Ive been meaning to tell you this.',
                        time: 'Just now',
                        hasNew: true),
                    ChatItemWidget(
                        title: 'Reekado Banks',
                        profileImage:
                            'https://images.unsplash.com/photo-1550751464-57982110c246?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                        messageClip: 'Hit me up',
                        time: '12:45 pm',
                        hasNew: true),
                    ChatItemWidget(
                        title: 'Helen Jane',
                        profileImage:
                            'https://images.unsplash.com/photo-1534109165916-7878ad66d5eb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                        messageClip: 'What are you gonnna be doing today?',
                        time: '11:31 am',
                        hasNew: false)
                  ],
                )
                */
