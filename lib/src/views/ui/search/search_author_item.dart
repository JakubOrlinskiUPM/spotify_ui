import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class SearchAuthorItem extends StatelessWidget {
  const SearchAuthorItem({Key? key, required this.id}) : super(key: key);

  static double height = 60;

  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Author>(
      future: BlocProvider.of<DataBloc>(context).getAuthorById(id),
      child: (Author author) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () =>
            _onButtonPressed(context, AUTHOR_VIEW_ROUTE + "/${author.id}"),
        child: Card(
          child: ListTile(
            tileColor: Colors.black,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 25,
              foregroundImage: CachedNetworkImageProvider(author.imageUrl)
            ),
            title: Text(author.name),
            subtitle: Text("Artist"),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
