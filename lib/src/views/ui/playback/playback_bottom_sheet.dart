import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/providers/playback_slider_provider.dart';
import 'package:spotify_ui/src/views/ui/playback/bottom_list_tile.dart';

import 'package:spotify_ui/src/views/ui/playback/playback_sheet.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';

class PlaybackBottomSheet extends StatelessWidget {
  const PlaybackBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state.playlist == null || state.song == null) {
          return Container(height: 0);
        }
        return Row(
          children: [
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 0.97,
                child: GestureDetector(
                  onTap: () => _onTap(context),
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff4c2d6c),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        BottomListTile(state: state),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: FractionallySizedBox(
                            widthFactor: context
                                .watch<PlaybackSliderProvider>()
                                .sliderValue,
                            child: Container(
                              height: 2.5,
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const PlaybackSheet();
        },
        fullscreenDialog: true));
  }
}
