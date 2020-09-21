import 'package:MyUnicircle/Controllers/settings_controller.dart';
import 'package:MyUnicircle/Views/Boardroom/my_pitch_projects.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends StateMVC<Settings> {
  SettingsController _con;

  _SettingsState() : super(SettingsController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    print("This the curent user ---- $currentUser");
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: ListTile(
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
                Positioned(top: 2, right: 1, child: indicator2())
              ]),
              title: Text(
                  '${currentUser.value.firstname} ${currentUser.value.lastname}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[900])),
              subtitle: Text('${currentUser.value.username}',
                  style: TextStyle(color: Colors.grey[900]))),
        ),
        Divider(),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text('MyUnicircle Special',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 20),
        ListTile(
            leading: Image.asset('assets/icons/money.png', height: 30),
            title: Text('My Projects',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPitchProjects()));
                })),



        ListTile(
            leading: Image.asset('assets/icons/money.png', height: 30),
            title: Text('Fund Project',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black),
                onPressed: () {})),


        ListTile(
            leading: Image.asset('assets/icons/medicine.png', height: 30),
            title: Text('Telemedicine',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black),
                onPressed: () {})),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text('Account Settings',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 20),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/Profile');
          },
          leading: Image.asset('assets/icons/profile.png', height: 40),
          title: Text('My Profile',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 20),
        ListTile(
            leading: Image.asset('assets/icons/billing.png', height: 40),
            title: Text('Billing',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black),
                onPressed: () {})),
        SizedBox(height: 20),
        ListTile(
            leading: Image.asset('assets/icons/friends.png', height: 40),
            title: Text('My Friends',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black),
                onPressed: () {})),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text('Application Preferences',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Image.asset('assets/icons/help.png', height: 40),
          title: Text('Hep & Support',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 20),
        ListTile(
          onTap: () {
            _con.logout();
          },
          leading: Image.asset('assets/icons/logout.png', height: 30),
          title: Text('Logout',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Image.asset('assets/icons/notification.png', height: 30),
          title: Text('Notifications',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 20),
      ],
    ));
  }

  Widget smallImage() {
    return ListTile(
        leading: Stack(children: [
          ClipOval(
            child: Image.asset('assets/images/sophia.jpg', height: 40),
          ),
          Positioned(top: 2, right: 1, child: indicator2())
        ]),
        title: Text('Blair Dota',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text('online', style: TextStyle(color: Colors.white)));
  }

  Widget indicator2() {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  Widget photoWrap() {
    return ClipOval(
      child: Image.asset('assets/images/sophia.jpg', height: 60),
    );
  }

  Widget leadIcon(IconData icon) {
    return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).accentColor),
        child: Center(child: Icon(icon, color: Colors.white)));
  }
}
