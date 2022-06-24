import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_carousel.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_marquee.dart';

class BottomListTile extends StatefulWidget {
  const BottomListTile({Key? key, required this.state}) : super(key: key);

  final PlayerState state;

  @override
  _BottomListTileState createState() => _BottomListTileState();
}

class _BottomListTileState extends State<BottomListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: SizedBox(
              width: 45,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: widget.state.song!.album.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlaybackCarousel(
              state: widget.state,
              childCallback: (int itemIndex) {
                print("childCallback " + itemIndex.toString());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if ((widget.state.playlist?.songs.length ?? 0) >
                        itemIndex) ...[
                      PlaybackMarquee(
                          title: widget.state.playlist?.songs[itemIndex].name ??
                              "",
                          authors: widget.state.playlist?.songs[itemIndex]
                                  .authorString ??
                              "",
                          songTextStyle:
                              Theme.of(context).textTheme.titleLarge!,
                          authorTextStyle:
                              Theme.of(context).textTheme.caption!),
                    ]
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => _onPlayPressed(context, widget.state),
            child: Icon(widget.state.status == PlayerStatus.playing
                ? Icons.pause
                : Icons.play_arrow),
          ),
        ),
      ],
    );
  }

  _onPlayPressed(BuildContext context, PlayerState state) {
    if (state.status != PlayerStatus.playing) {
      context.read<PlayerBloc>().add(PlayerStartedEvent());
    } else {
      context.read<PlayerBloc>().add(PlayerStoppedEvent());
    }
  }
}
