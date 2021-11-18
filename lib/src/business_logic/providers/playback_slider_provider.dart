import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaybackSliderProvider with ChangeNotifier {
  AudioPlayer audioPlayer;

  double _sliderValue = 0;
  Duration _position = const Duration(seconds: 0);
  Duration _duration = const Duration(seconds: 0);

  double get sliderValue => _sliderValue;
  Duration get duration => _duration;
  String get durationString => '''${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, "0")}''';
  String get positionString => '''${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, "0")}''';

  void setSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }


  void _onDurationChange(Duration duration) {
    _duration = duration;
    notifyListeners();
  }

  void _onAudioPositionChange(Duration position) {
    double sliderValue = duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0;
    _position = position;
    setSliderValue(sliderValue);
  }

  PlaybackSliderProvider(this.audioPlayer) {
    audioPlayer.onAudioPositionChanged.listen(_onAudioPositionChange);

    audioPlayer.onDurationChanged.listen(_onDurationChange);
  }
}