import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

const streamUrl =
    'https://streams.radiomast.io/4b6d766f-3b8a-422a-ab07-822a1738ff2f';

bool buttonState = true;

CustomAudioPlayer player = CustomAudioPlayer();

final playControl = MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
final pauseControl = MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
final stopControl = MediaControl(
    androidIcon: 'drawable/ic_action_stop',
    label: 'Stop',
    action: MediaAction.stop);

class Player {
  Future initPlaying() async {
    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
    await CustomAudioPlayer().onStart({
      'id': 'audio_1',
      'album': '88.7 FM',
      'title': 'Diamond FM',
    });
  }

  pause() async {
    AudioService.pause();
  }

  play() async {
    if (await AudioService.running) {
      // AudioService.play();
      CustomAudioPlayer().onPlay();
    } else {
      CustomAudioPlayer().onPlay();
      //initPlaying();
    }
  }

  updateMedia(Map<String, dynamic> _media) async {
    await AudioService.customAction('updateMedia', _media);
  }
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => CustomAudioPlayer());
}

class CustomAudioPlayer extends BackgroundAudioTask {
  Completer _completer = Completer();
  MediaItem mediaItem = MediaItem(
      id: 'audio_1',
      album: '88.7 FM',
      title: 'Diamond FM',
      artUri: 'https://diamondfm.net/images/diamond-fm-logo.jpeg');

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
  }

  @override
  onStart(Map<String, dynamic> params) async {
    AudioServiceBackground.setMediaItem(mediaItem);
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    await audioStart();
    //onPlay();
    await _completer.future;
  }

  @override
  Future<void> onPlay() {
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    return FlutterRadio.play(url: streamUrl);
  }

  @override
  Future<void> onPause() {
    AudioServiceBackground.setState(
        controls: [playControl, stopControl],
        playing: false,
        processingState: AudioProcessingState.ready);
    return FlutterRadio.pause(url: streamUrl);
  }

  @override
  Future<void> onStop() async {
    await FlutterRadio.stop();

    await super.onStop();
    await AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    exit(0);
  }

  @override
  Future onCustomAction(_function, params) {
    return AudioServiceBackground.setMediaItem(MediaItem(
        id: params['mediaID'],
        album: params['mediaAlbum'],
        title: params['mediaTitle'],
        artUri: params['mediaCover']));
  }
}
