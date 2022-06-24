import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/search/search_results.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  String query = "";

  @override
  void initState() {
    searchController.addListener(onInput);
    super.initState();
  }

  @override
  void deactivate() {
    searchController.removeListener(onInput);
    super.deactivate();
  }

  onInput() {
    if (searchController.text.length > 2) {
      setState(() {
        query = searchController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Hero(
            tag: "search-button-input",
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
                hintText: 'Search query',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: query.length <= 2
            ? const Center(
                child: Text("Type something in..."),
              )
            : SearchResults(query: query),
      ),
    );
  }
}
