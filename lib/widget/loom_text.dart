import 'package:flutter/material.dart';

class LoomText extends StatelessWidget {
  const LoomText(
    this.text, {
    Key? key,
    this.top,
    this.bottom,
    this.textSize,
  }) : super(key: key);

  final String text;
  final int? top;
  final int? bottom;
  final int? textSize;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Padding(
      padding: EdgeInsets.only(
        top: top != null ? (top! * devicePixelRatio) : 52.0 * devicePixelRatio,
        bottom: bottom != null
            ? (bottom! * devicePixelRatio)
            : 37.0 * devicePixelRatio,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: textSize != null
                ? (textSize! * devicePixelRatio)
                : 18 * devicePixelRatio,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
