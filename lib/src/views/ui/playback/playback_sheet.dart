import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaybackSheet extends StatelessWidget {
  const PlaybackSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff057cc9),
              Color(0xff000000),
            ],
            stops: [
              0,
              0.3
            ]),
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("title"),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.more_vert, size: 28),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [Text("title"), Text("author")],
                    ),
                    const Icon(CupertinoIcons.heart),
                  ],
                ),
                Slider(
                  value: 0.2,
                  onChanged: _onChanged,
                ),

                Row(
                  children: [
                    IconButton(icon: Icon(Icons.shuffle), onPressed: _onShufflePressed,),
                    IconButton(icon: Icon(Icons.home), onPressed: _onBackPressed,),
                    IconButton(icon: Icon(Icons.pause), onPressed: _onPlayPressed,),
                    IconButton(icon: Icon(Icons.forward), onPressed: _onForwardPressed,),
                    IconButton(icon: Icon(Icons.repeat), onPressed: _onRepeatPressed,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onChanged(double value) {}
  void _onShufflePressed() {}
  void _onBackPressed() {}
  void _onPlayPressed() {}
  void _onForwardPressed() {}
  void _onRepeatPressed() {}
}
