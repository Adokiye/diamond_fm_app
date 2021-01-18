import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Widget loadingCircle() {
  return Center(
    child: SpinKitCircle(
      color: Colors.lightGreenAccent[200],
      size: 50,
    ),
  );
}
