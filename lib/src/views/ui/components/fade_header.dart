import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/utils.dart';

class FadeHeader extends StatefulWidget {
  const FadeHeader({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.heroString,
    this.color = 4284045657,
    this.imageFullSize = false,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String heroString;
  final int color;
  final bool imageFullSize;

  @override
  State<FadeHeader> createState() => _FadeHeaderState();
}

class _FadeHeaderState extends State<FadeHeader> {
  double minFrac = 0.25;
  double expandedHeight = 300;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        double frac = ((expandedHeight - constraints.scrollOffset) / expandedHeight);
        frac = frac.clamp(0, 1);
        double textOpacity = 1 - (frac - 0.25);
        textOpacity = textOpacity > 0.95 ? textOpacity : 0;
        textOpacity = textOpacity.clamp(0, 1);

        return SliverAppBar(
          // backgroundColor: Colors.transparent,
          leading: Stack(
            children: [
              if (widget.imageFullSize)
                ...[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Opacity(
                      opacity: frac,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900.withAlpha(200),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                  ),
                ],
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          pinned: true,
          expandedHeight: expandedHeight,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(widget.color), darken(Color(widget.color), 70)],
              ),
            ),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              title: Opacity(
                opacity: textOpacity,
                child: SafeArea(
                  child: Text(
                    widget.title,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(widget.color), Colors.black],
                  ),
                ),
                child: frac > 0.4 ? _buildImage(frac) : Container(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(frac) {
    if (widget.imageFullSize) {
      return Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      );
    } else {
      return SafeArea(
        child: FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: frac,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Hero(
              tag: widget.heroString,
              child: CachedNetworkImage(
                  imageUrl: widget.imageUrl, fit: BoxFit.fitHeight),
            ),
          ),
        ),
      );
    }
  }
}
