import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_sheet.dart';

class PlaybackBottomSheet extends StatelessWidget {
  const PlaybackBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () => _onTap(context),
          child: Container(
              height: 55,
              decoration: const BoxDecoration(
                  color: Colors.black26,
                  border: Border(bottom: BorderSide(color: Colors.black))),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text("PlaybackBottomSheet"),
              )),
        )),
      ],
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const PlaybackSheet();
        },
        fullscreenDialog: true));
    // showModalBottomSheet<void>(
    //   useRootNavigator: true,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return PlaybackSheet();
    //   },
    // );
  }
}
