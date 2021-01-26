import 'package:diamond_fm_app/src/views/News%20Page/NewsPage.dart';
import 'package:diamond_fm_app/src/views/Social%20Media%20Page/SocialMediaPage.dart';
import 'package:diamond_fm_app/src/views/home/ListenPage.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(Icons.headset, color: Colors.white),
                    title: Text(
                      'Listen',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => ListenPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ballot, color: Colors.white),
                    title: Text(
                      'News',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => NewsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.chat_bubble, color: Colors.white),
                    title: Text(
                      'Social Media',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SocialMediaPage(
                                url:
                                    'https://www.facebook.com/diamond887fmilorin/',
                              )));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                  url:
                                      'https://www.facebook.com/diamond887fmilorin/',
                                )));
                      },
                      child: Image.asset('assets/facebooklogo.png'),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                  url: 'https://twitter.com/diamond887fm',
                                )));
                      },
                      child: Image.asset('assets/twitterlogo.png'),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                url: 'https://instagram.com/diamond887fm/')));
                      },
                      child: Image.asset('assets/instagramlogo.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
