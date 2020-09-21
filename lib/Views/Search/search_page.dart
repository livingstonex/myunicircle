import 'package:MyUnicircle/Controllers/search_controller.dart';
import 'package:MyUnicircle/Views/Chat/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends StateMVC<SearchPage> {
  SearchController _con;

  _SearchPageState() : super(SearchController()) {
    _con = controller;
  }

  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text('Search Friend',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            iconTheme: IconThemeData(color: Colors.black)),
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200]),
              child: TextField(
                  controller: searchController,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String value) {
                    _con.setState(() {
                      _con.usersList = null;
                    });
                    _con.searchUser(searchQuery: value);
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            searchController.clear();
                          }),
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey)))),
          _con.usersList == null
              ? Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ))
              : _con.usersList.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          SizedBox(height: 50),
                          Image.asset('assets/icons/no_data.png', height: 150),
                          // SizedBox(height: 10),
                          Text(
                            'No results found',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          )
                        ])
                  : Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                "Found ${_con.usersList.length} ${_con.usersList.length == 1 ? 'Person' : 'People'}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 20),
                          ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _con.usersList.length,
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatMain(
                                          receiver: _con.usersList[index],
                                          name: _con.usersList[index].username,
                                          image: _con.usersList[index].image)));
                                },
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: 39,
                                    backgroundColor: Colors.grey[100],
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${_con.usersList[index].image}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
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
                                      placeholder: (context, url) => Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                          size: 30),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                title: Text(
                                    '${_con.usersList[index].firstname} ${_con.usersList[index].lastname}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                                subtitle: Text(
                                    '${_con.usersList[index].username}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                trailing: addFriendBtn(_con.usersList[index]),
                              );
                            },
                          )
                        ],
                      ))
        ])));
  }

  Widget addFriendBtn(user) {
    return IconButton(
        icon: Icon(Icons.person_add, size: 30),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatMain(
                  receiver: user, name: user.username, image: user.image)));
        });
  }
}
