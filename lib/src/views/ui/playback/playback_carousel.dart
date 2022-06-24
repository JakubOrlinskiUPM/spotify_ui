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
  bool _isUserScroll = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 1,
      initialPage: widget.state.songIndex,
    );

    subscription =
        BlocProvider.of<PlayerBloc>(context).stream.listen((PlayerState state) {
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
    return NotificationListener<UserScrollNotification>(
      onNotification: (UserScrollNotification notification) {
        _isUserScroll = true;
        return true;
      },
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (ScrollEndNotification notification) {
          if (_isUserScroll && notification.depth == 0 &&
              notification is ScrollEndNotification) {
            _onPageChanged(context, pageController.page?.ceil() ?? 0);

            _isUserScroll = false;
          }
          return false;
        },
        child: PageView.builder(
          itemCount: widget.state.playlist?.songIds.length,
          controller: pageController,
          itemBuilder: (BuildContext context, int itemIndex) {
            return widget.childCallback(itemIndex);
          },
        ),
      ),
    );
  }

  void _onPageChanged(BuildContext context, int pageNo) {
    if (!_isBlocked) {
      if (widget.state.playlist != null) {
        Song s = widget.state.playlist!.songs[pageNo];
        if (widget.state.song != s) {
          lock();
          BlocProvider.of<PlayerBloc>(context).add(PlayerSetSongEvent(song: s));
        }
      }
    }
  }

  void lock([int? duration]) {
    _isBlocked = true;
    Future.delayed(Duration(milliseconds: duration ?? 300), () {
      _isBlocked = false;
    });
  }
}
