import 'package:diamond_fm_app/src/components/AppBar.dart';
import 'package:diamond_fm_app/src/components/MenuBar.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final String title;
  MyScaffold({this.body, this.title});
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuBar(),
      backgroundColor: Color(0xff06060c),
      appBar: appBarView(title: widget.title),
      body: widget.body,
    );
  }
}
