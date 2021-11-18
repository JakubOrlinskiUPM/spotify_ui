import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_sheet.dart';

class PlaybackCarousel extends StatefulWidget {
  const PlaybackCarousel({Key? key, required this.state}) : super(key: key);

  final PlayerState state;

  @override
  _PlaybackCarouselState createState() => _PlaybackCarouselState();
}

class _PlaybackCarouselState extends State<PlaybackCarousel> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 1,
      initialPage: widget.state.songIndex,
    );

    BlocProvider.of<PlayerBloc>(context)
        .audioPlayer
        .onPlayerCompletion
        .listen((event) {
      pageController.animateToPage(
        (pageController.page?.floor() ?? 0) + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        itemCount: widget.state.playlist?.songs.length,
        controller: pageController,
        onPageChanged: (int pageNo) => _onPageChanged(context, pageNo),
        itemBuilder: (BuildContext context, int itemIndex) {
          return Padding(
            padding: const EdgeInsets.all(PlaybackSheet.EDGE_PADDING),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              repeat: ImageRepeat.noRepeat,
              imageUrl:
                  widget.state.playlist?.songs[itemIndex].album.coverUrl ?? "",
            ),
          );
        },
      ),
    );
  }

  void _onPageChanged(BuildContext context, int pageNo) {
    if (widget.state.playlist != null) {
      Song s = widget.state.playlist!.songs[pageNo];
      BlocProvider.of<PlayerBloc>(context)
        .add(PlayerSetSongEvent(song: s));
    }
  }
}
