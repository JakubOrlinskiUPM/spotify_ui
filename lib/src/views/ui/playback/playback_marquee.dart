import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:spotify_ui/src/views/ui/utils.dart';

class PlaybackMarquee extends StatelessWidget {
  const PlaybackMarquee({Key? key, required this.text}) : super(key: key);
  final String text;

  static TextStyle songTextStyle = TextStyle(color: Colors.white, fontSize: 28);
  static TextStyle authorTextStyle =
      TextStyle(color: Colors.grey.shade400, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: LayoutBuilder(builder: (context, box) {
        Size s = getTextSize(text, songTextStyle);
        if (s.width > box.biggest.width) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: s.height,
                child: Marquee(
                  style: songTextStyle,
                  text: text,
                  velocity: 40.0,
                  blankSpace: 25,
                  startAfter: const Duration(seconds: 2),
                  pauseAfterRound: const Duration(seconds: 3),
                  fadingEdgeEndFraction: 0.1,
                  fadingEdgeStartFraction: 0.1,
                ),
              ),
              Text("author", style: authorTextStyle),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: songTextStyle,
              ),
              Text("author", style: authorTextStyle),
            ],
          );
        }
      }),
    );
  }
}
