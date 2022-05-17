import 'dart:convert';

import 'package:flutter/material.dart';

class MiddleDot extends StatelessWidget {
  const MiddleDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(utf8.decode([
        0xE2,
        0x80,
        0xA2
      ])),
    );
  }
}
