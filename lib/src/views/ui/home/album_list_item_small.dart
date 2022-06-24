import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/recently_played.dart';
import 'package:spotify_ui/src/business_logic/models/viewable.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/home/album_item_loading.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';
import 'package:uuid/uuid.dart';

class AlbumListItemSmall extends StatelessWidget {
  AlbumListItemSmall({Key? key, required this.recentlyPlayed})
      : super(key: key);

  static double height = 70;

  final RecentlyPlayed recentlyPlayed;

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 2;
    itemWidth -= height;
    itemWidth -= 10;
    itemWidth -= 8;

    return CustomFutureBuilder<Viewable>(
      future: BlocProvider.of<DataBloc>(context)
          .getRecentlyPlayedItem(recentlyPlayed),
      loading: AlbumItemLoading(),
      child: (Viewable item) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () =>
            _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${item.id}"),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: height,
            color: Colors.grey.shade800,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: height,
                  height: height,
                  child: CachedNetworkImage(
                      imageUrl: item.imageUrl, fit: BoxFit.fill),
                ),
                SizedBox(
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.name),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
