import 'dart:async';

import 'package:diamond_fm_app/src/components/MyScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volume_control/volume_control.dart';

class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  var streamingController = StreamingController();
  int maxVolume;
  double currentVolume = 0.5;

  bool buttonState = true;
  bool isOpened = false;

  bool onPlay = false;
  Timer timer;

  @override
  void initState() {
    initVolumeState();
    updateVolume();
    streamingController.config(
        url:
            'https://streams.radiomast.io/4b6d766f-3b8a-422a-ab07-822a1738ff2f');
    super.initState();
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Are you sure you want to quit?'),
            content:
                new Text('The application will be closed and radio stopped!'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () async {
                  await streamingController.stop();

                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: MyScaffold(
        title: 'Listen',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Color(0xFF0d0d1b),
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff0d0d1b),
                    radius: 123,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF000015),
                      radius: 120,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                            image: AssetImage(
                              'assets/diamondfm.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('Listen Live',
                      style: TextStyle(
                        color: Color(0XFFF7921E),
                        fontSize: 25,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Diamond FM 88.7',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      )),
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
                        onPressed: () async {
                          setState(() {
                            if (currentVolume >= 0.1) {
                              currentVolume = currentVolume - 0.1;
                            }
                          });
                          await setVolume(currentVolume);
                        },
                      ),
                      Expanded(
                          child: Slider.adaptive(
                        activeColor: Color(0xffB4D433),
                        inactiveColor: Colors.white,
                        value: currentVolume,
                        min: 0,
                        max: 1,
                        divisions: 100,
                        label: (currentVolume * 100).round().toString(),
                        onChanged: (double value) async {
                          //use timer for the smoother sliding
                          timer = Timer(Duration(milliseconds: 200), () async {
                            await setVolume(value);
                          });
                        },
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            if (currentVolume <= 0.9) {
                              currentVolume = currentVolume + 0.1;
                            }
                          });

                          await setVolume(currentVolume);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: new Container(
                  decoration: BoxDecoration(
                    color: Color(0xffB4D433),
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(MediaQuery.of(context).size.width),
                        topRight:
                            Radius.circular(MediaQuery.of(context).size.width)),
                  ),
                  child: StreamBuilder(
                      stream: streamingController.streamingController.stream,
                      builder: (context, snapshot) {
                        return Center(
                            child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    icon: Icon(
                                      snapshot.hasData &&
                                              snapshot.data == 'playing_event'
                                          ? Icons.stop
                                          : Icons.play_arrow,
                                      color: Color(0xffB4D433),
                                      size: 35,
                                    ),
                                    onPressed: () async {
                                      snapshot.hasData &&
                                              snapshot.data == 'playing_event'
                                          ? streamingController.pause()
                                          : streamingController.play();
                                    })));
                      })),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initVolumeState() async {
    if (!mounted) return;

    //read the current volume
    double _val = await VolumeControl.volume;
    setState(() {
      currentVolume = _val;
    });
    print('current' + currentVolume.toString());
  }

  updateVolume() async {
    //maxVolume = await VolumeControl.;
    double _val = await VolumeControl.volume;

    setState(() {
      currentVolume = _val;
    });
    print('current' + currentVolume.toString());

    //  _currentSliderValue = currentVolume;
  }

  setVolume(double i) async {
    await VolumeControl.setVolume(i);
    setState(() {
      currentVolume = i;
    });
  }
}

class StreamingController {
  MethodChannel _channel;
  var streamingController = StreamController<String>();

  StreamingController() {
    _channel = const MethodChannel('streaming_channel');
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'playing_event':
          streamingController.sink.add(call.method);
          return 'Playing, ${call.arguments}';
        case 'paused_event':
          streamingController.sink.add(call.method);
          return 'Paused, ${call.arguments}';
        case 'stopped_event':
          streamingController.sink.add(call.method);
          return 'Stopped, ${call.arguments}';
        case 'loading_event':
          streamingController.sink.add(call.method);
          return 'Loading, ${call.arguments}';
        default:
          throw MissingPluginException();
      }
    });
  }

  Future<void> config({
    String url,
  }) async {
    try {
      String result = await _channel.invokeMethod('config', <String, dynamic>{
        'url': url,
        'notification_title': "Test ",
        'notification_description': "Description",
        'notification_color': "#FF0000",
        'notification_stop_button_text': "Stop",
        'notification_pause_button_text': "Pause",
        'notification_play_button_text': "Play",
        'notification_playing_description_text': "Playing",
        'notification_stopped_description_text': "Stopped"
      });
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> play() async {
    try {
      String result = await _channel.invokeMethod('play', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> pause() async {
    try {
      String result = await _channel.invokeMethod('pause', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> stop() async {
    try {
      String result = await _channel.invokeMethod('stop', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  void dispose() {
    streamingController.close();
  }
}
