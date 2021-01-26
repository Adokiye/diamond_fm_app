import 'dart:async';
import 'package:diamond_fm_app/src/components/LoadingCircle.dart';
import 'package:diamond_fm_app/src/views/home/ListenPage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool onLoading = true;
  Timer timer;
  loadingChange() {
    timer = Timer(Duration(milliseconds: 3000), () {
      setState(() {
        onLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    loadingChange();
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('assets/diamondfm.png'), //TODO
              ),
            ),
          ),
          Visibility(
            child: loadingCircle(),
            visible: onLoading,
            replacement: RaisedButton(
              // clipBehavior: Clip(),
              elevation: 10,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ListenPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'CONTINUE',
                  style: TextStyle(color: Color(0xffF7921E), fontSize: 22),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
