import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaybackSliderProvider with ChangeNotifier {
  AudioPlayer audioPlayer;

  double _sliderValue = 0;
  Duration _duration = const Duration(seconds: 0);

  double get sliderValue => _sliderValue;
  Duration get duration => _duration;

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
    setSliderValue(sliderValue);
  }

  PlaybackSliderProvider(this.audioPlayer) {
    audioPlayer.onAudioPositionChanged.listen(_onAudioPositionChange);

    audioPlayer.onDurationChanged.listen(_onDurationChange);
  }
}