import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder(
      {Key? key, required this.child, required this.future})
      : super(key: key);

  final Widget Function(T) child;
  final Future future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return child(snapshot.data as T);
        } else if (snapshot.hasError) {
          return Center(
              child: Container(
            child: Text("Error"),
          ));
          // return ErrorScreen();
        } else {
          return Center(
              child: Container(
            child: Text("Loading"),
          ));
          // return LoadingScreen();
        }
      },
    );
  }
}
