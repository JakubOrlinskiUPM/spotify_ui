import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:spotify_ui/src/views/ui/utils.dart';

class PlaybackMarquee extends StatelessWidget {
  PlaybackMarquee({
    Key? key,
    required this.title,
    required this.authors,
    this.songTextStyle = const TextStyle(color: Colors.white, fontSize: 28),
    this.authorTextStyle = const TextStyle(color: Colors.grey, fontSize: 20),
  }) : super(key: key);

  final String title;
  final String authors;
  final TextStyle songTextStyle;
  final TextStyle authorTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: LayoutBuilder(builder: (context, box) {
        Size s = getTextSize(title, songTextStyle);
        if (s.width > box.biggest.width) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: s.height,
                child: Marquee(
                  style: songTextStyle,
                  text: title,
                  velocity: 40.0,
                  blankSpace: 25,
                  startAfter: const Duration(seconds: 2),
                  pauseAfterRound: const Duration(seconds: 3),
                  fadingEdgeEndFraction: 0.1,
                  fadingEdgeStartFraction: 0.1,
                ),
              ),
              Text(authors, style: authorTextStyle),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: songTextStyle,
              ),
              Text(authors, style: authorTextStyle),
            ],
          );
        }
      }),
    );
  }
}
