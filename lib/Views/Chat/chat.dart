//import 'dart:io';
import 'dart:io';
import 'package:MyUnicircle/Controllers/chat_controller.dart';
import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/Views/Chat/widget/cached_image.dart';
import 'package:MyUnicircle/constants/strings.dart';
import 'package:MyUnicircle/enum/view_state.dart';
import 'package:MyUnicircle/provider/image_provider.dart';
import 'package:MyUnicircle/utilities/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:MyUnicircle/resources/firebase_repository.dart' as _repository;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMain extends StatefulWidget {
  final User receiver;
  final String name;
  final String image;

  const ChatMain({Key key, this.name, this.image, this.receiver})
      : super(key: key);
  @override
  _ChatMainState createState() => _ChatMainState();
}

class _ChatMainState extends StateMVC<ChatMain> {
  ChatController _con;

  _ChatMainState() : super(ChatController()) {
    _con = controller;
  }

  ScrollController _listScrollController = ScrollController();
  FocusNode textFieldFocus = FocusNode();
  bool isWriting = false;
  bool showEmojiPicker = false;
  TextEditingController textController = TextEditingController();
  ImageUploadProvider _imageUploadProvider;

  showKeyBoard() => textFieldFocus.requestFocus();
  hideKeyBoard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  pickImage({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);
    _repository.uploadImage(
        image: selectedImage,
        receiverId: widget.receiver.id,
        senderId: currentUser.value.id,
        imageUploadProvider: _imageUploadProvider);
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _con.scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[800],
        title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 19,
                backgroundColor: Colors.grey[100],
                child: CachedNetworkImage(
                  imageUrl: "${widget.image}",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 50,
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
                      Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),
            title: Text('${widget.name}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            subtitle: Text('online',
                style: TextStyle(fontSize: 10, color: Colors.white))),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Column(children: [
        Flexible(child: messageList()),
        _imageUploadProvider.getViewState == ViewState.LOADING
            ? Container(
                margin: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: CircularProgressIndicator(),
              )
            : Container(),
        chatControls(),
        showEmojiPicker ? Container(child: emojiContainer()) : Container()
      ]),
    );
  }

  Widget emojiContainer() {
    return EmojiPicker(
      bgColor: Colors.black87,
      rows: 3,
      columns: 7,
      indicatorColor: Theme.of(context).accentColor.withOpacity(.5),
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });
        textController.text = textController.text + emoji.emoji;
      },
    );
  }

  Widget messageList() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(MESSAGES_COLLECTION)
            .document(currentUser.value.id)
            .collection(widget.receiver.id)
            .orderBy(TIMESTAMP_FIELD, descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator()));
          }
/*
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _listScrollController.animateTo(
                _listScrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut);
          });
          */
          return ListView.builder(
              reverse: true,
              controller: _listScrollController,
              itemCount: snapshot.data.docs.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return chatMessageItem(snapshot.data.docs[index]);
              });
        });
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {

    MessageModel _message = MessageModel.fromMap(snapshot.data());
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Container(child: layout(_message)));
  }

  _ago(Timestamp t) {
    return timeago.format(t.toDate());
  }

  Widget layout(MessageModel message) {
    var date = DateTime.fromMicrosecondsSinceEpoch(
        message.timestamp.microsecondsSinceEpoch);
    Radius messageRadius = Radius.circular(10);
    return Align(
        alignment: message.senderId == currentUser.value.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: message.senderId == currentUser.value.id
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 5),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65),
                decoration: BoxDecoration(
                    color: message.senderId == currentUser.value.id
                        ? Theme.of(context).accentColor
                        : Colors.grey[100],
                    borderRadius: message.senderId == currentUser.value.id
                        ? BorderRadius.only(
                            topRight: messageRadius,
                            topLeft: messageRadius,
                            bottomLeft: messageRadius)
                        : BorderRadius.only(
                            topRight: messageRadius,
                            bottomRight: messageRadius,
                            bottomLeft: messageRadius)),
                child: Padding(
                    padding: EdgeInsets.all(10), child: getMessage(message))),
            SizedBox(height: 5),
            Text('$date')
          ],
        ));
  }

  getMessage(MessageModel message) {
    return message.type != MESSAGE_TYPE_IMAGE
        ? Text(message.message,
            style: TextStyle(
                color: message.senderId == currentUser.value.id
                    ? Colors.white
                    : Colors.black))
        : message.photoUrl != null
            ? CachedImage(url: message.photoUrl)
            : Text('Url was null');
  }

  addMediaModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.black87,
        builder: (context) {
          return Column(children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(children: [
                  FlatButton(
                    child: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Add Item',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))))
                ])),
            Flexible(
                child: ListView(children: [
              ModalTile(
                  title: 'Media',
                  subtitle: 'Share photos & videos',
                  onTap: () => pickImage(source: ImageSource.gallery),
                  icon: Icons.image),
              Divider(),
              ModalTile(
                  title: 'Camera',
                  subtitle: 'Take an image',
                  onTap: () => pickImage(source: ImageSource.camera),
                  icon: Icons.camera_alt),
              Divider(),
              ModalTile(
                  title: 'Contact',
                  subtitle: 'Share contact',
                  icon: Icons.person),
              Divider(),
              ModalTile(
                  title: 'Location',
                  subtitle: 'Share your location',
                  icon: Icons.add_location),
              Divider(),
              ModalTile(
                  title: 'File',
                  subtitle: 'Share a file or document',
                  icon: Icons.tab)
            ]))
          ]);
        });
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    return Container(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).accentColor,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
              child: TextField(
                  keyboardType: TextInputType.multiline,
                  //maxLines: 5,
                  onTap: () => hideEmojiContainer(),
                  focusNode: textFieldFocus,
                  controller: textController,
                  style: TextStyle(color: Colors.black),
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != '')
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: InputDecoration(
                    hintText: 'Type message',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ))),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.mic, color: Theme.of(context).accentColor)),
          isWriting
              ? Container()
              : GestureDetector(
                  onTap: () {
                    if (!showEmojiPicker) {
                      hideKeyBoard();
                      showEmojiContainer();
                    } else {
                      showKeyBoard();
                      hideEmojiContainer();
                    }
                  },
                  child:
                      Icon(Icons.face, color: Theme.of(context).accentColor)),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle),
                  child: IconButton(
                      icon: Icon(Icons.send, size: 20, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isWriting = false;
                        });

                        _con.sendMessage(
                            text: textController.text,
                            receiver: widget.receiver);
                        textController.clear();
                      }))
              : Container()
        ]));
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const ModalTile({Key key, this.title, this.subtitle, this.icon, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListTile(
            onTap: onTap,
            leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).accentColor.withOpacity(.5),
                ),
                padding: EdgeInsets.all(10),
                child:
                    Icon(icon, color: Theme.of(context).accentColor, size: 30)),
            subtitle: Text(subtitle,
                style: TextStyle(color: Colors.white, fontSize: 13)),
            title: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold))));
  }
}
