import 'package:flutter/material.dart';

class LoomButton extends StatelessWidget {
  const LoomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        minimumSize: MaterialStateProperty.all(const Size(150, 2)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
