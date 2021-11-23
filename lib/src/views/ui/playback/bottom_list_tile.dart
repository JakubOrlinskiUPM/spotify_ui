import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_carousel.dart';

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
          child: CachedNetworkImage(
              height: 35, imageUrl: widget.state.song!.album.coverUrl),
        ),
        Expanded(
          flex: 4,
          child: PlaybackCarousel(
            state: widget.state,
            childCallback: (int itemIndex) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.state.playlist?.songs[itemIndex].title ?? ""),
                Text(widget.state.playlist?.songs[itemIndex].authorString ?? "",
                    style: Theme.of(context).textTheme.caption),
              ],
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
