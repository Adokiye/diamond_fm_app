import 'package:flutter_radio/flutter_radio.dart';
import 'package:diamond_fm_app/src/components/MyScaffold.dart';
import 'package:flutter/material.dart';
import 'package:volume/volume.dart';


class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  int maxVolume;
  int currentVolume;
  double _currentSliderValue = 15;
  // final assetsAudioPlayer = AssetsAudioPlayer();
  bool onPlay = false;
  String radioUrl = 'http://95.110.227.3:8000/diamond';

  @override
  void initState() {
    super.initState();
    initVolumeState();
    updateVolume();
    audioStart();
  }

  Future<void> initVolumeState() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolume() async {
    maxVolume = await Volume.getMaxVol;
    currentVolume = await Volume.getVol;
    _currentSliderValue = currentVolume.toDouble();
  }

  setVolume(int i) async {
    await Volume.setVol(i);
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
                          onPressed: () async {
                            setState(() {
                              if (_currentSliderValue >= 1.0) {
                                _currentSliderValue = _currentSliderValue - 1.0;
                              }
                            });
                            await setVolume(_currentSliderValue.toInt());
                            await updateVolume();
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
                          onChanged: (double value) async {
                            setState(() {
                              _currentSliderValue = value;
                            });

                            await setVolume(_currentSliderValue.toInt());
                            await updateVolume();
                          },
                        )),
                        IconButton(
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            setState(() {
                              if (_currentSliderValue <= 14.0) {
                                _currentSliderValue = _currentSliderValue + 1.0;
                              }
                            });

                            await setVolume(_currentSliderValue.toInt());
                            await updateVolume();
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
              ),
            ],
          ),
        ]));
  }

  Future playingStatus() async {
    bool isPlaying = await FlutterRadio.isPlaying();
    setState(() {
      onPlay = isPlaying;
    });
  }
}
