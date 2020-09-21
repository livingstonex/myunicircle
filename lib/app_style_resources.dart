import 'package:flutter/material.dart';


Color appColor1 = Colors.deepPurple;
Color appColor2 = Colors.purple;
Color appColorBlackShade = Colors.black54;
Color appColorBlack = Colors.black;
Color appColorSmoke = Color(0xffC0C0C0);
Color appColorWhite = Colors.white;
Color appColorShade = Color(0xfff5f5f5);


const Small = 13.0;
const Medium = 15.0;
const Large = 20.0;



const String OTP_Address = "https://www.9jayarns.com/kopo/phone_otp.php";
const String Load_BVN = "https://www.9jayarns.com/kopo/resolve_bvn.php";
const String Insert_User = "https://www.9jayarns.com/kopo/insert_user.php";

const String CURRENT_PROJECTS = "https://myunicircle.com/uni_c/current_donation.php";
const String ALL_PROJECTS = "https://myunicircle.com/uni_c/select_projects.php";
const String INSERT_PROJECTS = "https://myunicircle.com/uni_c/insert_projects.php";
const String USER_PROJECTS = "https://myunicircle.com/uni_c/select_user_projects.php?id=";
const String UPDATE_LIVE = "https://myunicircle.com/uni_c/update_live.php?id=";

const String ALL_FEEDS = "https://myunicircle.com/uni_c/all_friends_feeds.php";

//App Custom TextStyles
TextStyle smallText(Color colors) =>  TextStyle(
    color: colors,
    fontSize: Small,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300
);



TextStyle mediumText(Color colors) =>  TextStyle(
    color: colors,
    fontSize: Medium,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300
);



TextStyle mediumTextBold(Color colors) =>  TextStyle(
    color: colors,
    fontSize: Medium,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w600
);


TextStyle largeText(Color colors) =>  TextStyle(
    color: colors,
    fontSize: Large,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300
);

TextStyle largeTextBold(Color colors) =>  TextStyle(
    color: colors,
    fontSize: Large,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w600
);