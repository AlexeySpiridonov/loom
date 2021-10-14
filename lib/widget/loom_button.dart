import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class LoomButton extends StatelessWidget {
  const LoomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.loomEvent,
    this.isModalBottomSheet,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;
  final LoomEvent loomEvent;
  final bool? isModalBottomSheet;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            Color.fromRGBO(0, 195, 243, 1),
            Color.fromRGBO(21, 98, 216, 1),
          ],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(6 * devicePixelRatio),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6 * devicePixelRatio),
            ),
          ),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 20)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10 * devicePixelRatio,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context
                      .read<LoomBloc>()
                      .add(LoomOpenFAQEvent(loomEvent: loomEvent));
                  if (isModalBottomSheet ?? false) Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 12 * devicePixelRatio,
                  backgroundColor: const Color.fromRGBO(47, 55, 94, 0.3),
                  child: Text(
                    "?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14 * devicePixelRatio,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * devicePixelRatio,
                  ),
                ),
              ),
              SizedBox(width: 22 * devicePixelRatio),
            ],
          ),
        ),
      ),
    );
  }
}
