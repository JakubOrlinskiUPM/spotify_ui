import 'package:flutter/material.dart';

class BottomSheetDismissBar extends StatelessWidget {
  const BottomSheetDismissBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.grey,
      ),
      width: 50,
      height: 4,
    );
  }
}
