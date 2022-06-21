import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SongItemLoading extends StatelessWidget {
  SongItemLoading({Key? key}) : super(key: key);

  final Color baseColor = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        enabled: true,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 8.0),
            leading: Container(
              color: baseColor,
              width: 50,
              height: 50,
            ),
            trailing: SizedBox(width: 10,),
            title: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.8,
              child: Container(
                height: 15,
                color: baseColor,
              ),
            ),
            subtitle: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              child: Container(
                color: baseColor,
                height: 10,
              ),
            ),
          ),
        ),
        baseColor: baseColor,
        highlightColor: Colors.white,
        loop: 1000,
      ),
    );
  }
}
