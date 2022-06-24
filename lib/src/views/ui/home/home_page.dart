import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/views/ui/home/grid_list.dart';
import 'package:spotify_ui/src/views/ui/components/sidescrolling_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    BlocProvider.of<DataBloc>(context).add(DataFetchRecentlyPlayed());
    BlocProvider.of<DataBloc>(context).add(DataFetchRecommended());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.black],
              stops: [0, 0.2]
          ),
        ),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              GridList(name: "Recently played", list: state.recentlyPlayed.sublist(0, min(state.recentlyPlayed.length, 6))),
              SidescrollingList(
                name: "Recommended for today",
                list: state.recommended,
              ),
            ],
          ),
        ),
      );
    });
  }
}
