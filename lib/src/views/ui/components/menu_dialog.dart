import 'package:flutter/material.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({Key? key}) : super(key: key);

  @override
  _MenuDialogState createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: const [
            Text("Menu"),
          ],
        ),
      ),
    );
  }
}
