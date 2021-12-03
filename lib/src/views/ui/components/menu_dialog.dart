import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({
    Key? key,
    required this.playlist,
    this.song,
    required this.navigator
  }) : super(key: key);

  final Playlist playlist;
  final Song? song;
  final NavigatorState navigator;

  @override
  _MenuDialogState createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            children: [
              GestureDetector(
                excludeFromSemantics: true,
                onTap: _goBack,
                child: SizedBox(
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: widget.song?.album.coverUrl ?? "",
                  ),
                ),
              ),
              Text(
                widget.song!.title,
              ),
              Text(widget.song!.authorString,
                  style: Theme.of(context).textTheme.caption),
              _buildMenuOption(
                CupertinoIcons.heart,
                "Liked",
                _likedPressed,
                false,
              ),
              _buildMenuOption(
                Icons.queue_music_outlined,
                "Add to playlist",
                _playlistAddPressed,
                false,
              ),
              _buildMenuOption(
                Icons.queue_music_outlined,
                "Add to queue",
                _queueAddPressed,
                false,
              ),
              _buildMenuOption(
                Icons.album_outlined,
                "View album",
                _albumViewPressed,
                false,
              ),
              _buildMenuOption(
                Icons.share,
                "Share",
                _sharePressed,
                false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String text, callback, bool active) {
    return TextButton(
      onPressed: callback,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  void _goBack() {
    Navigator.pop(context);
  }

  void _likedPressed() {}

  void _playlistAddPressed() {}

  void _queueAddPressed() {}

  void _albumViewPressed() {
    // widget.navigator.pushNamed(PLAYLIST_VIEW_ROUTE,
    //     arguments: {"playlist": widget.song?.album});
    Navigator.of(context).pop();
  }

  void _sharePressed() {}
}
