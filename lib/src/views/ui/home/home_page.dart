import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/views/ui/components/sidescrolling_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          child: Column(
            children: [
              SidescrollingList(
                name: "Recently played",
                list: state.recentlyPlayed,
              ),
            ],
          ),
        ),
      );
    });
  }
}
