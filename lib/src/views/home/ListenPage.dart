import 'package:diamond_fm_app/src/components/MySemiCircle.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:diamond_fm_app/src/components/MyScaffold.dart';
import 'package:flutter/material.dart';

class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  double _currentSliderValue = 15;
  bool onPlay = false;
  // bool isVisible = true;
  String radioUrl = 'http://95.110.227.3:8000/diamond';
  // FlutterRadio radio = FlutterRadio();

  @override
  void initState() {
    super.initState();
    audioStart();
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: 'Listen',
        body: Stack(alignment: Alignment.center, children: [
          ListView(
            children: [
              Container(
                color: Color(0xFF000015),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffB4D433),
                      radius: 123,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF000015),
                        radius: 120,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/diamondfm.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Listen Live',
                        style: TextStyle(
                          color: Color(0XFFF7921E),
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Diamond FM 88.7',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.volume_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_currentSliderValue >= 1.0) {
                                _currentSliderValue = _currentSliderValue - 1.0;
                                // FlutterRadio.setVolume(_currentSliderValue);
                              }
                            });
                          },
                        ),
                        Expanded(
                            child: Slider.adaptive(
                          activeColor: Color(0xffB4D433),
                          inactiveColor: Colors.white,
                          value: _currentSliderValue,
                          min: 0,
                          max: 15,
                          divisions: 15,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        )),
                        IconButton(
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_currentSliderValue <= 14.0) {
                                _currentSliderValue = _currentSliderValue + 1.0;
                                // FlutterRadio.setVolume(_currentSliderValue);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Color(0xffB4D433),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  MediaQuery.of(context).size.width),
                              topRight: Radius.circular(
                                  MediaQuery.of(context).size.width)),
                        ),
                        child: Center(
                            child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    onPlay ? Icons.stop : Icons.play_arrow,
                                    color: Color(0xffB4D433),
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      onPlay = !onPlay;
                                      onPlay
                                          ? FlutterRadio.play(url: radioUrl)
                                          : FlutterRadio.pause(url: radioUrl);
                                    });
                                  },
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
