import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:MyUnicircle/Views/The_Bag/send_money.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class TheBagComponent extends StatefulWidget {
  @override
  _TheBagComponentState createState() => _TheBagComponentState();
}

class _TheBagComponentState extends State<TheBagComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Stack(
        children: [
          Container(height: 380),
          Container(
              alignment: Alignment.centerLeft,
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).accentColor,
                        Theme.of(context).primaryColorDark
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Entypo.wallet, color: Colors.white, size: 100),
                  SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your balance',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        SizedBox(height: 8),
                        Text('\$2000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700))
                      ])
                ],
              )),
          Positioned(
              top: 170,
              child: Container(
                  height: 190,
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [card(), card(), card()])))
        ],
      ),
      RoundedButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        text: "Send Money",
        press: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SendMoney()));
        },
      ),
      SizedBox(height: 15),
      lastTransactions()
    ]));
  }

  Widget card({Color color, String owner, String image, String lastDigit}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        margin: EdgeInsets.all(8),
        width: 300,
        height: 170,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset('assets/images/mastercard.png', height: 70),
                IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {
                      print('more');
                    })
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Blair Dota', style: TextStyle(color: Colors.white)),
                Text('**** **** **** 1234',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22)),
                Text('VALID 10/22', style: TextStyle(color: Colors.white)),
              ])
            ]));
  }

  Widget smallImage() {
    return ListTile(
        leading: Stack(children: [
          ClipOval(
            child: Image.asset('assets/images/sophia.jpg', height: 40),
          ),
          Positioned(top: 2, right: 1, child: indicator2())
        ]),
        title:
            Text('Blair Dota', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('online',
            style: TextStyle(color: Theme.of(context).accentColor)));
  }

  Widget chatIcon() {
    return Stack(children: [
      IconButton(
          icon: Icon(Ionicons.ios_chatbubbles),
          onPressed: () {
            Navigator.of(context).pushNamed('/ChatHome');
          }),
    ]);
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

  Widget lastTransactions() {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text('Last Transactions',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
      SizedBox(height: 10),
      ListTile(
          leading: sendIcon(),
          title: Text('John Lenning',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text('12-06-2020',
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
          trailing: Text('-\$500',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green))),
      ListTile(
          leading: sendIcon(),
          title: Text('John Lenning',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text('12-06-2020',
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
          trailing: Text('-\$500',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green))),
      ListTile(
          leading: sendIcon(),
          title: Text('John Lenning',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text('12-06-2020',
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
          trailing: Text('-\$500',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green))),
      ListTile(
          leading: sendIcon(),
          title: Text('John Lenning',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text('12-06-2020',
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
          trailing: Text('-\$500',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green)))
    ]));
  }

  Widget sendIcon() {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).accentColor),
        child: Center(child: Icon(Ionicons.ios_send, color: Colors.white)));
  }
}
