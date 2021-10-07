import 'package:flutter/material.dart';

class LoomText extends StatelessWidget {
  const LoomText(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 2,
        ),
      ),
    );
  }
}
