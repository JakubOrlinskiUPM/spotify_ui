import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_sheet.dart';

class PlaybackCarousel extends StatefulWidget {
  const PlaybackCarousel(
      {Key? key, required this.state, required this.childCallback})
      : super(key: key);

  final PlayerState state;
  final Function childCallback;

  @override
  _PlaybackCarouselState createState() => _PlaybackCarouselState();
}

class _PlaybackCarouselState extends State<PlaybackCarousel> {
  late PageController pageController;
  late StreamSubscription subscription;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 1,
      initialPage: widget.state.songIndex,
    );

    subscription = BlocProvider
        .of<PlayerBloc>(context)
        .stream
        .listen((PlayerState state) {
      if (!_isBlocked) {
        if (state.songIndex != widget.state.songIndex) {
          pageController.animateToPage(
            state.songIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      } else {
        _isBlocked = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.state.playlist?.songs.length,
      controller: pageController,
      onPageChanged: (int pageNo) => _onPageChanged(context, pageNo),
      itemBuilder: (BuildContext context, int itemIndex) {
        return widget.childCallback(itemIndex);
      },
    );
  }

  void _onPageChanged(BuildContext context, int pageNo) {
    if (widget.state.playlist != null) {
      Song s = widget.state.playlist!.songs[pageNo];
      lock();
      BlocProvider.of<PlayerBloc>(context)
          .add(PlayerSetSongEvent(song: s));
    }
  }

  void lock() {
    _isBlocked = true;
    Future.delayed(const Duration(milliseconds: 200), () {
      _isBlocked = false;
    });
  }
}
