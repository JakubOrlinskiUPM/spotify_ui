import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PlaybackMarquee extends StatelessWidget {
  const PlaybackMarquee({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 20,
      child: Marquee(
        text: "There once was a boy who told",
        velocity: 30.0,
        blankSpace: 25,
        startAfter: const Duration(seconds: 2),
        pauseAfterRound: const Duration(seconds: 3),
      ),
    );
  }
}
