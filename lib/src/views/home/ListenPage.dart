import 'dart:async';

import 'package:flutter_radio/flutter_radio.dart';
import 'package:diamond_fm_app/src/components/MyScaffold.dart';
import 'package:flutter/material.dart';
import 'package:volume/volume.dart';
import 'package:volume_control/volume_control.dart';

class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  int maxVolume;
  double currentVolume = 0.5;
  double _currentSliderValue = 0.5;
  // final assetsAudioPlayer = AssetsAudioPlayer();
  bool onPlay = false;
  String radioUrl = 'http://95.110.227.3:8000/diamond';
  Timer timer;

  @override
  void initState() {
    super.initState();
    initVolumeState();
    updateVolume();
    audioStart();
  }

  //old doesn't support ios
  // Future<void> initVolumeState() async {
  //   await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  // }

  //init volume_control plugin
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

  Future<void> audioStart() async {
    if (!await FlutterRadio.isPlaying()) {
      await FlutterRadio.audioStart();
    } else {
      setState(() {
        onPlay = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool onPlay = assetsAudioPlayer.isPlaying.value;
    return MyScaffold(
        title: 'Listen',
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
                color: Color(0xFF0d0d1b),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
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
                     SizedBox(
                      height: 30,
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
                          onPressed: () async {
                            setState(() {
                              if (currentVolume >= 0.1) {
                                currentVolume = currentVolume - 0.1;
                              }
                            });
                            await setVolume(currentVolume);
                            //    await updateVolume();
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
                          label: (currentVolume*100).round().toString(),
                          onChanged: (double value) async {
                            //use timer for the smoother sliding
                            timer =
                                Timer(Duration(milliseconds: 200), () async {
                              await setVolume(value);
                           //   await updateVolume();
                            });

                            print("val:${value}");
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
                            //  await updateVolume();
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
                                    // assetsAudioPlayer.isPlaying.value
                                    //     ? assetsAudioPlayer.stop()
                                    //     : assetsAudioPlayer
                                    //         .open(Audio.liveStream(radioUrl));
                                  },
                                ))),
                      ),
                    ),
            ],
          ),
        );
  }

  Future playingStatus() async {
    bool isPlaying = await FlutterRadio.isPlaying();
    setState(() {
      onPlay = isPlaying;
    });
  }
}
