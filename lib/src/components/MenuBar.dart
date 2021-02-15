import 'package:diamond_fm_app/src/views/News%20Page/NewsPage.dart';
import 'package:diamond_fm_app/src/views/Social%20Media%20Page/SocialMediaPage.dart';
import 'package:diamond_fm_app/src/views/home/ListenPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff06060c),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffB4D433),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(Icons.headset, color: Color(0xffB4D433)),
                    title: Text(
                      'Listen',
                      style: TextStyle(color: Color(0xffB4D433)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => ListenPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ballot, color: Color(0xffB4D433)),
                    title: Text(
                      'News',
                      style: TextStyle(color: Color(0xffB4D433)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => NewsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.chat_bubble, color: Color(0xffB4D433)),
                    title: Text(
                      'Social Media',
                      style: TextStyle(color: Color(0xffB4D433)),
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
                   GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                  url:
                                      'https://www.facebook.com/diamond887fmilorin/',
                                )));
                      },
                      child:FaIcon(FontAwesomeIcons.facebook,color: Color(0xffb4d433),size: 24,)),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                  url: 'https://twitter.com/diamond887fm',
                                )));
                      },
                      child: FaIcon(FontAwesomeIcons.twitter,color: Color(0xffb4d433),size: 24,),
                    ),
                  SizedBox(
                    width: 30,
                  ),
               GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SocialMediaPage(
                                url: 'https://instagram.com/diamond887fm/')));
                      },
                      child: FaIcon(FontAwesomeIcons.instagram,color: Color(0xffb4d433),size: 24,),
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
