import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class LoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LoomEvent loomEvent;
  final String text;

  const LoomAppBar({
    Key? key,
    required this.loomEvent,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Padding(
      padding: EdgeInsets.only(
        top: 42 * devicePixelRatio,
        bottom: 15 * devicePixelRatio,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 21 * devicePixelRatio),
          GestureDetector(
            onTap: () => context.read<LoomBloc>().add(loomEvent),
            child: SvgPicture.asset(
              "assets/images/back.svg",
              height: 16 * devicePixelRatio,
            ),
          ),
          SizedBox(width: 16 * devicePixelRatio),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16 * devicePixelRatio,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
