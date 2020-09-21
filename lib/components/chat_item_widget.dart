import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/Views/Chat/chat.dart';
import 'package:MyUnicircle/Widgets/online_dot_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/resources/firebase_methods.dart' as firebaseRepo;
import 'package:MyUnicircle/resources/user_repository.dart' as userRepo;

class ChatItemWidget extends StatefulWidget {
  final User receiver;
  final bool hasNew;
  final String title;
  final String profileImage;
  final String time;
  final String messageClip;

  const ChatItemWidget(
      {Key key,
      this.hasNew,
      this.title,
      this.profileImage,
      this.time,
      this.messageClip,
      this.receiver})
      : super(key: key);

  @override
  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatMain(
                receiver: widget.receiver,
                name: widget.receiver.firstname,
                image: widget.receiver.image)));
      },
      contentPadding: EdgeInsets.only(right: 8),
      leading: leadingImage(),
      title: Text('${widget.receiver.firstname}',
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: LastMessage(
          stream: firebaseRepo.fetchLastMessageBetween(
              senderId: userRepo.currentUser.value.id,
              receiverId: widget.receiver.id)),
      trailing: trailingWidget(hasNew: widget.hasNew, time: '10am'),
    );
  }

  Widget trailingWidget({bool hasNew, String time}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (hasNew == true) ? newMessageIdicator() : SizedBox.shrink(),
              Text('10am',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w700,
                      fontSize: 12))
            ]));
  }

  Widget newMessageIdicator() {
    return Container(
        // padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        height: 15,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text('new',
                style: TextStyle(color: Colors.white, fontSize: 10))));
  }

  Widget leadingImage() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.green,
      child: CircleAvatar(
        radius: 39,
        backgroundColor: Colors.grey[100],
        child: CachedNetworkImage(
          imageUrl: '${widget.receiver.image}',
          imageBuilder: (context, imageProvider) => Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
          placeholder: (context, url) =>
              Icon(Icons.person, color: Colors.grey, size: 30),
          errorWidget: (context, url, error) =>
              Icon(Icons.person, color: Colors.grey),
        ),
      ),
    ) /*
    Stack(children: [
      
      OnlineDotIndicator(id: widget.receiver.id)
    ])*/
        ;
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
