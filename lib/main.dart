import 'package:MyUnicircle/Views/Chat/chat_list.dart';
import 'package:MyUnicircle/Views/Homepage/home.dart';
import 'package:MyUnicircle/Views/Post/create_post.dart';
import 'package:MyUnicircle/Views/Profile/profile.dart';
import 'package:MyUnicircle/Views/Search/search_page.dart';
import 'package:MyUnicircle/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/Controllers/controller.dart';
import 'package:MyUnicircle/Views/splash.dart';
import 'package:MyUnicircle/Views/Signup/signup_screen2.dart';
import 'package:MyUnicircle/Views/Signup/otp_screen.dart';
import 'package:MyUnicircle/Views/Login/login_screen2.dart';
import 'package:MyUnicircle/Views/Welcome/welcome_screen.dart';
import 'package:MyUnicircle/Views/Signup/name_screen.dart';
import 'package:MyUnicircle/Views/Chats/chat_landing.dart';
import 'package:MyUnicircle/Views/Chats/main_chat.dart';
import 'package:MyUnicircle/Views/The_Bag/landing.dart';
import 'package:MyUnicircle/Views/The_Bag/send_money.dart';
import 'package:MyUnicircle/Views/Onboarding/onboarding.dart';
import 'package:MyUnicircle/Views/Boardroom/board_room_home.dart';
import 'package:MyUnicircle/Views/Boardroom/upload_pitch.dart';
import 'package:MyUnicircle/Views/Settings/settings.dart';
import 'package:MyUnicircle/Views/Donation/landing.dart';
import 'package:MyUnicircle/Views/NewsFeed/show_news.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends AppMVC {
  MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageUploadProvider>(
        create: (context) => ImageUploadProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyUnicircle',
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/Home': (context) => HomePage(),
            '/Login': (context) => LoginScreen(),
            '/Register': (context) => SignUpScreen(),
            '/VerifyEmail': (context) => VerificationScreen(),
            '/Welcome': (context) => WelcomeScreen(),
            '/NameScreen': (context) => NameScreen(),
            '/ChatHome': (context) => ChatLanding(),
            '/ChatSingle': (context) => MainChat(),
            '/TheBagHome': (context) => TheBagComponent(),
            '/SendMoney': (context) => SendMoney(),
            '/Onboarding': (context) => Onboarding(),
            '/BoardRoom': (context) => BoardRoom(),
            '/UploadPitch': (context) => UploadPitch(),
            '/Settings': (context) => Settings(),
            '/Donation': (context) => DonationLanding(),
            '/Profile': (context) => Profile(),
            '/NewsFeed': (context) => ShowNews(),
            '/SearchPage': (context) => SearchPage(),
            '/CreatePost': (context) => CreatePost(),
            '/ChatList': (context) => ChatList()
          },
          theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              accentColor: Color(0xFFEC0C6D),
              canvasColor: Colors.grey[200],
              primaryColor: Colors.white,
              primaryColorDark: Color(0xFFC726AC),
              primarySwatch: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Poppins'),
        ));
  }
}
