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

  @override
  void initState() {
    super.initState();
    loadingChange();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  loadingChange() {
    timer = Timer(Duration(milliseconds: 3000), () {
      setState(() {
        onLoading = false;
      });
       return Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ListenPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child:Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
   // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
              Container(
             height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width*0.5,
                child:Image.asset('assets/diamondfm.png')),
            Text('Shining Supreme',
            style: TextStyle(color: Colors.red, fontSize: 32),),
          // Visibility(
          //   child: loadingCircle(),
          //   visible: onLoading,
          //   replacement: RaisedButton(
          //     // clipBehavior: Clip(),
          //     elevation: 10,
          //     color: Colors.white,
          //     onPressed: () async {
          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
          //           builder: (BuildContext context) => ListenPage()));
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Text(
          //         'CONTINUE',
          //         style: TextStyle(color: Color(0xffF7921E), fontSize: 22),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 30,
          // ),
          Spacer(),

        ],
      ),
     ) );
  }
}
