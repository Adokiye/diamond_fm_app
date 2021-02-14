import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Widget loadingCircle() {
  return Center(
    child: SpinKitCircle(
      color: Color(0xffB4D433),
      size: 50,
    ),
  );
}
