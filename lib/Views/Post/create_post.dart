import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:MyUnicircle/Controllers/post_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends StateMVC<CreatePost> {
  PostController _con;

  _CreatePostState() : super(PostController()) {
    _con = controller;
  }
  TextEditingController postController = new TextEditingController();
  List<File> images = List<File>();
  String _error = 'No Error Dectected';

  _notifier(String serverRes) {
    _con.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(serverRes)));
  }

  maxImage() {
    if (images.length == 5) {
      return _notifier('Maximum amount of uploads reached');
    } else {
      _openGallery(context);
    }
  }

  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // showMaterialModalBottomSheet(
              //   context: context,
              //   builder: (context, scrollController) => Container(
              //       height: 200,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(5),
              //               topRight: Radius.circular(5))),
              //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              //       child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             FlatButton(
              //                 onPressed: () {
              //                   maxImage();
              //                 },
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                         height: 40,
              //                         width: 40,
              //                         child: Center(
              //                           child: Image.asset(
              //                               'assets/icons/gallery.png'),
              //                         )),
              //                     SizedBox(width: 10),
              //                     Text('Add Photo')
              //                   ],
              //                 )),
              //             Divider(),
              //             FlatButton(
              //                 onPressed: () {
              //                   _openCamera(context);
              //                 },
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                         height: 40,
              //                         width: 40,
              //                         child: Center(
              //                           child: Image.asset(
              //                               'assets/icons/camera.png'),
              //                         )),
              //                     SizedBox(width: 10),
              //                     Text('Camera')
              //                   ],
              //                 )),
              //             Divider(),
              //             FlatButton(
              //                 onPressed: () {
              //                   Navigator.of(context).pop();
              //                   Navigator.of(context).pop();
              //                 },
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                         height: 40,
              //                         width: 40,
              //                         child: Center(
              //                           child: Image.asset(
              //                               'assets/icons/discard.png'),
              //                         )),
              //                     SizedBox(width: 10),
              //                     Text('Discard Post')
              //                   ],
              //                 ))
              //           ])),
              // );
            },
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0.5,
          title: Text('Create Post', style: TextStyle(fontSize: 14)),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            FlatButton(
              onPressed: () {
                _con.addPost(body: postController.text, files: images);
              },
              child: Text('Post now',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          ListTile(
              leading: Stack(children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 39,
                    backgroundColor: Colors.grey[100],
                    child: CachedNetworkImage(
                      imageUrl: "${currentUser.value.image}",
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
                          Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              ]),
              title: Text(
                  '${currentUser.value.firstname} ${currentUser.value.lastname}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[900])),
              subtitle: Text('${currentUser.value.username}',
                  style: TextStyle(color: Colors.grey[900]))),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(fontSize: 22)))),
          SizedBox(height: 40),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: buildGridView())
        ])));
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return _notifier('No image selected');
    } else {
      setState(() {
        imageFile = picture;
      });
      print(imageFile);
    }
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return _notifier('No image selected');
    } else {
      setState(() {
        images.add(picture);
      });
      print(imageFile);
    }
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      children: List.generate(images.length + 1, (index) {
        if (index == 0) {
          return addPhotoBtn();
        }
        File file = images[index - 1];
        return Container(
            width: 50,
            child: Stack(children: [
              Image.file(file, height: 120, width: 70),
              removeBtn(file)
            ]));
      }),
    );
  }

  Widget removeBtn(file) {
    return InkWell(
        onTap: () {
          setState(() {
            images.remove(file);
          });
        },
        child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.withOpacity(.8)),
            child: Center(child: Icon(Icons.remove, size: 8))));
  }

  Widget addPhotoBtn() {
    return InkWell(
        onTap: () {
          maxImage();
        },
        child: Container(
            height: 80,
            width: 40,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300]),
            child: Center(child: Icon(Icons.add))));
  }
}
