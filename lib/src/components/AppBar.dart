import 'package:flutter/material.dart';

Widget appBarView({String title}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.lightGreenAccent[200],
    elevation: 8,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.white),
    ),
  );
}
