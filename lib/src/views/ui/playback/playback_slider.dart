import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/providers/playback_slider_provider.dart';


class PlaybackSlider extends StatefulWidget {
  const PlaybackSlider({Key? key, required this.state}) : super(key: key);

  final PlayerState state;

  @override
  _PlaybackSliderState createState() => _PlaybackSliderState();
}

class _PlaybackSliderState extends State<PlaybackSlider> {
  static const double THUMB_SIZE_SMALL = 5;
  static const double THUMB_SIZE_BIG = 8;
  double _sliderThumbSize = THUMB_SIZE_SMALL;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          alignment: Alignment.center,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white,
              thumbColor: Colors.white,
              trackShape: CustomTrackShape(),
              trackHeight: 2,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: _sliderThumbSize),
            ),
            child: Slider(
              value: context.watch<PlaybackSliderProvider>().sliderValue,
              onChanged: (double pos) => _onPositionChanged(pos, context),
              onChangeStart: (double pos) {
                setState(() {
                  _sliderThumbSize = THUMB_SIZE_BIG;
                });
              },
              onChangeEnd: (double pos) {
                setState(() {
                  _sliderThumbSize = THUMB_SIZE_SMALL;
                });
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(context.watch<PlaybackSliderProvider>().positionString),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text(context.watch<PlaybackSliderProvider>().durationString),
        ),
      ],
    );
  }

  void _onPositionChanged(double value, BuildContext context) {
    context.read<PlaybackSliderProvider>().setSliderValue(value);
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
