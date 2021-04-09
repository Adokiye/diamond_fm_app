import 'package:flutter/material.dart';

widthSizer(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * (value / 414);
}

heightSizer(double value, BuildContext context) {
  return MediaQuery.of(context).size.height * (value / 896);
}
