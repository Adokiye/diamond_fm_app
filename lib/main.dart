import 'package:diamond_fm_app/src/views/News%20Page/NewsPage.dart';
import 'package:diamond_fm_app/src/views/Social%20Media%20Page/SocialMediaPage.dart';
import 'package:diamond_fm_app/src/views/Splash%20Page/SplashPage.dart';
import 'package:diamond_fm_app/src/views/home/ListenPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //player.initPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Axiforma'),
      home: SplashPage(),
      routes: {
        '/listen': (context) => ListenPage(),
        '/news': (context) => NewsPage(),
        '/social': (context) =>
            SocialMediaPage(url: 'https://www.facebook.com/diamond887fmilorin/')
      },
    );
  }
}
