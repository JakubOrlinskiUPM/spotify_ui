import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/providers/playback_slider_provider.dart';

class PositionSlider extends StatelessWidget {
  const PositionSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FractionallySizedBox(
        widthFactor: context
            .watch<PlaybackSliderProvider>()
            .sliderValue,
        child: Container(
          height: 2.5,
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
