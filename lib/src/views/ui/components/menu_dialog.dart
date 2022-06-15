import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class MenuDialogReturn {
  final String route;
  final Map? arguments;

  MenuDialogReturn({required this.route, this.arguments});
}

class MenuDialog extends StatefulWidget {
  const MenuDialog({Key? key, required this.playlist, this.song})
      : super(key: key);

  final Playlist playlist;
  final Song? song;

  @override
  _MenuDialogState createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Hero(
                  tag: widget.song!.heroString,
                  child: CachedNetworkImage(
                    imageUrl: widget.song!.album.coverUrl,
                  ),
                ),
              ),
              Text(
                widget.song!.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                widget.song!.authorString,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
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
                Icons.person,
                "View artist",
                _artistViewPressed,
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
        ],
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

  void _goBack(MenuDialogReturn? returnData) {
    Navigator.of(context, rootNavigator: true).pop(returnData);
  }

  void _likedPressed() {}

  void _playlistAddPressed() {}

  void _queueAddPressed() {}

  void _albumViewPressed() {
    _goBack(MenuDialogReturn(
      route: PLAYLIST_VIEW_ROUTE + "/${widget.song!.album.id}",
    ));
  }

  void _artistViewPressed() {
    _goBack(MenuDialogReturn(
      route: AUTHOR_VIEW_ROUTE + "/${widget.song!.authors[0].id}",
    ));
  }

  void _sharePressed() {}
}
