import 'dart:convert';

import 'package:MyUnicircle/Models/feeds_model.dart';
import 'package:MyUnicircle/Views/Boardroom/newboardroom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shimmer/shimmer.dart';

import '../../app_style_resources.dart';

class NewsWidget extends StatefulWidget {
  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {

  bool isLoading = false;
  List<AllFeeds> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/SearchPage');
                        },
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200]),
                            child: Row(children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 5),
                              Text('Search',
                                  style: TextStyle(color: Colors.grey))
                            ]))),
                    SizedBox(height: 15),
                    Divider(),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.videocam, color: Colors.red),
                                SizedBox(width: 3),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewboardRoom()));
                                  },
                                  child: Text('Live Pitch',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                )
                              ]),
                              Text('|', style: TextStyle(color: Colors.grey)),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/CreatePost');
                                  },
                                  child: Row(children: [
                                    Icon(Icons.photo_album,
                                        color: Colors.green),
                                    SizedBox(width: 3),
                                    Text('Create Moments',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))
                                  ]))
                            ])),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("Moments",
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2)),
                            SizedBox()
                          ]),
                    ),


                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 180,
                        child:

//
//                            makeStory(
//                                storyImage: 'assets/images/paint1.jpg',
//                                userImage: 'assets/images/steven.jpg',
//                                userName: 'Steven Kings'),
//                            makeStory(
//                                storyImage: 'assets/images/paint2.jpg',
//                                userImage: 'assets/images/sam.jpg',
//                                userName: 'Lindy Rayton'),
//                            makeStory(
//                                storyImage: 'assets/images/paint3.jpg',
//                                userImage: 'assets/images/olivia.jpg',
//                                userName: 'Olivia Reynolds'),


                            FutureBuilder(
                              future: getFeeds(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: isLoading
                                        ? Container(
                                        height: MediaQuery.of(context).size.height * .8,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            shimmerStoryLoading(),
                                            SizedBox(width: 10,),
                                            shimmerStoryLoading(),
                                            SizedBox(width: 10,),
                                            shimmerStoryLoading(),
                                          ],
                                        ))
                                        : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.perm_scan_wifi,
                                          size: 50,
                                          color: appColorSmoke,
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            getFeeds();
                                          },
                                          color: appColorSmoke,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Text(
                                            "Error, try Again",
                                            style: largeText(appColorBlack),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  var res_data = jsonDecode(snapshot.data);
                                  if (res_data["message"] == "Success") {

                                    //print(res_data["response"][0]);


                                    if(res_data["response"] == null){

                                      return Column(
                                        children: <Widget>[

                                          SizedBox(
                                            height: 20,
                                          ),


                                          Text(
                                              "No recent feeds",
                                              style: largeText(appColorBlack)
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          GestureDetector(
                                            onTap: (){
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPitch()));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: Text(
                                                "Post Feeds",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );


                                    }else{

                                      List<dynamic> data1 = res_data["response"];

                                      data =
                                          data1.map((dynamic item) => AllFeeds.fromJson(item)).toList();

                                      return ListView(
                                        scrollDirection: Axis.horizontal,
                                          children: data
                                              .map((AllFeeds feed) =>  makeStory(
                                              storyImage: feed.media,
                                              userImage: feed.media,
                                              userName: feed.user_name))
                                              .toList());

                                    }

                                  }
                                }

                                return Container(
                                    height: MediaQuery.of(context).size.height * .8,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        shimmerStoryLoading(),
                                        SizedBox(width: 10,),
                                        shimmerStoryLoading(),
                                        SizedBox(width: 10,),
                                        shimmerStoryLoading(),
                                      ],
                                    ));
                              },
                            ),


                        ),
                    SizedBox(height: 40),
//                    makeFeed(
//                        userName: 'Olivia Anderson',
//                        userImage: 'assets/images/olivia.jpg',
//                        feedTime: 'just now',
//                        feedImage: 'assets/images/paint1.jpg',
//                        feedText:
//                            'This is a wonderful work of art. Truly a masterpiece in the design!'),
//                    makeFeed(
//                        userName: 'Charity Benson',
//                        userImage: 'assets/images/sam.jpg',
//                        feedTime: '2 hr ago',
//                        feedImage: 'assets/images/paint2.jpg',
//                        feedText: 'Art in its best form. This touches my soul'),
//
//                    makeFeed(
//                        userName: 'Charity Benson',
//                        userImage: 'assets/images/sam.jpg',
//                        feedTime: '2 hr ago',
//                        feedImage: 'assets/images/paint2.jpg',
//                        feedText: 'Art in its best form. This touches my soul'),



                    FutureBuilder(
                      future: getFeeds(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: isLoading
                                ? Container(
                                height: MediaQuery.of(context).size.height * .8,
                                child: ListView(
                                  children: <Widget>[
                                    shimmerLoading(),
                                    shimmerLoading(),
                                    shimmerLoading(),
                                  ],
                                ))
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.perm_scan_wifi,
                                  size: 50,
                                  color: appColorSmoke,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    getFeeds();
                                  },
                                  color: appColorSmoke,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Error, try Again",
                                    style: largeText(appColorBlack),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          var res_data = jsonDecode(snapshot.data);
                          if (res_data["message"] == "Success") {

                            //print(res_data["response"][0]);


                            if(res_data["response"] == null){

                              return Column(
                                children: <Widget>[

                                  SizedBox(
                                    height: 20,
                                  ),


                                  Text(
                                      "You have no project pitched for funding",
                                      style: largeText(appColorBlack)
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPitch()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Text(
                                        "Pitch A Project",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );


                            }else{

                              List<dynamic> data1 = res_data["response"];

                              data =
                                  data1.map((dynamic item) => AllFeeds.fromJson(item)).toList();

                              return Column(
                                  children: data
                                      .map((AllFeeds feed) =>  makeFeed(
                                      userName: feed.user_name,
                                      userImage: feed.media,
                                      feedTime: feed.created_at,
                                      feedImage: feed.media,
                                      feedText: feed.title))
                                      .toList());

                            }

                          }
                        }

                        return Container(
                            height: MediaQuery.of(context).size.height * .8,
                            child: ListView(
                              children: <Widget>[
                                shimmerLoading(),
                                shimmerLoading(),
                                shimmerLoading(),
                              ],
                            ));
                      },
                    ),



                  ])))
    ]);
  }





  Future<String> getFeeds() async {

    try {
      http.Response response = await http.get(ALL_FEEDS);
      print("Response  ---- " + response.body.toString());
      if (response.statusCode == 200) {

        return response.body;
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception(e);
    }
  }



  Future<String> getStories() async {

    try {
      http.Response response = await http.get(ALL_FEEDS);
      print("Response  ---- " + response.body.toString());
      if (response.statusCode == 200) {

        return response.body;
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception(e);
    }
  }



  Widget shimmerLoading() {
    return Shimmer.fromColors(
        baseColor: appColorShade,
        highlightColor: Colors.white,
        period: Duration(seconds: 1, microseconds: 1),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: appColorShade, borderRadius: BorderRadius.circular(10)),
        ));
  }


  Widget shimmerStoryLoading() {
    return Shimmer.fromColors(
        baseColor: appColorShade,
        highlightColor: Colors.white,
        period: Duration(seconds: 1, microseconds: 1),
        child: Container(
          height: 160,
          width: 130,
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: appColorShade, borderRadius: BorderRadius.circular(10)),
        ));
  }



  Widget makeStory({storyImage, userImage, userName}) {
    return Container(
        width: 130,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(storyImage), fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(userImage),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text(userName, style: TextStyle(color: Colors.white))
                ])));
  }

  Widget makeFeed({userName, userImage, feedTime, feedImage, feedText}) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(userImage),
                                  fit: BoxFit.cover))),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                            SizedBox(height: 3),
                            Text(feedTime,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13))
                          ])
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.more_horiz,
                          size: 30, color: Colors.grey[600]),
                      onPressed: () => print('More'))
                ]),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(feedText,
                style: TextStyle(
                    color: Colors.grey[800], height: 1.5, letterSpacing: .7)),
          ),
          SizedBox(height: 20),
          Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(feedImage), fit: BoxFit.cover))),
          SizedBox(height: 20),
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
                        style: TextStyle(color: Colors.grey[900], fontSize: 15))
                  ]),
                  Text('400 commments',
                      style: TextStyle(color: Colors.grey[900], fontSize: 13))
                ]),
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    makeLikeButton(isActive: true),
                    makeCommentButton(),
                  ]))
        ]));
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

  Widget makeLikeButton({isActive}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.thumb_up,
              color: (isActive) ? Colors.blue : Colors.grey, size: 18),
          SizedBox(width: 5),
          Text('Like',
              style: TextStyle(color: (isActive) ? Colors.blue : Colors.grey))
        ])));
  }

  Widget makeCommentButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.chat, color: Colors.grey, size: 18),
          SizedBox(width: 5),
          Text('Comment', style: TextStyle(color: Colors.grey))
        ])));
  }


  Widget makeShareButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.share, color: Colors.grey, size: 18),
          SizedBox(width: 5),
          Text('Share', style: TextStyle(color: Colors.grey))
        ])));
  }
}
