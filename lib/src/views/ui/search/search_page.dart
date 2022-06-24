import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/search/search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Search",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Hero(
                        tag: "search-button-input",
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(SEARCH_VIEW);
                          },
                          icon: Icon(Icons.search),
                          label: Text(
                            "Artists, songs or playlists",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
