import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class SearchSongItem extends StatelessWidget {
  const SearchSongItem({Key? key, required this.id}) : super(key: key);

  static double height = 60;

  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Song>(
      future: BlocProvider.of<DataBloc>(context).getSongById(id),
      child: (Song song) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () =>
            _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${song.album.id}"),
        child: Card(
          child: ListTile(
            tileColor: Colors.black,
            contentPadding: EdgeInsets.zero,
            leading: SizedBox(
              width: height,
              height: height,
              child: CachedNetworkImage(imageUrl: song.album.imageUrl, fit: BoxFit.fill,),
            ),
            title: Text(song.name),
            subtitle: Row(
              children: [
                Text("Song"),
                const MiddleDot(),
                Text(song.authors[0].name),
              ],
            ),
          ),),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
