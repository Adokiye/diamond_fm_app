import 'package:flutter/material.dart';

Widget appBarView({String title}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xffB4D433),
    elevation: 8,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.white),
    ),
  );
}
