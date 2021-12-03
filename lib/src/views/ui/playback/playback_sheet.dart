import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_carousel.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_controls.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_marquee.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_slider.dart';

class PlaybackSheet extends StatefulWidget {
  const PlaybackSheet({Key? key}) : super(key: key);

  static const double EDGE_PADDING = 28;
  static const double ICON_SIZE = 50;

  @override
  _PlaybackSheetState createState() => _PlaybackSheetState();
}

class _PlaybackSheetState extends State<PlaybackSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff057cc9),
                Color(0xff000000),
              ],
              stops: [
                0,
                0.5
              ]),
        ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(state.song?.title ?? ""),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.more_vert, size: 28),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PlaybackCarousel(
                      state: state,
                      childCallback: (int itemIndex) => Padding(
                        padding:
                            const EdgeInsets.all(PlaybackSheet.EDGE_PADDING),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          repeat: ImageRepeat.noRepeat,
                          imageUrl:
                              state.playlist?.songs?[itemIndex].album.coverUrl ??
                                  "",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(PlaybackSheet.EDGE_PADDING),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PlaybackMarquee(
                              title: state.song?.title ?? "",
                              authors: state.song?.authors
                                      .map((a) => a.name)
                                      .join(", ") ??
                                  "",
                            ),
                            Container(
                              width: 50,
                              alignment: Alignment.centerRight,
                              child: const Icon(CupertinoIcons.heart),
                            ),
                          ],
                        ),
                      ),
                      PlaybackSlider(state: state),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: PlaybackControls(state: state)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Colors.grey.shade400,
                            iconSize: 0.4 * PlaybackSheet.ICON_SIZE,
                            icon: const Icon(Icons.speaker_group_outlined),
                            onPressed: _onSharePressed,
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 0.4 * PlaybackSheet.ICON_SIZE,
                                icon: const Icon(Icons.share),
                                onPressed: _onSharePressed,
                              ),
                              IconButton(
                                iconSize: 0.4 * PlaybackSheet.ICON_SIZE,
                                icon: const Icon(Icons.queue_music_outlined),
                                onPressed: _onSharePressed,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _onSharePressed() {}
}
