import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';

class LoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LoomEvent loomEvent;
  final bool questionMark;

  const LoomAppBar(
      {Key? key, required this.questionMark, required this.loomEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.read<LoomBloc>().add(loomEvent),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        children: const [
          Text("Loom", style: TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        questionMark
            ? TextButton(
                onPressed: () =>
                    context.read<LoomBloc>().add(LoomOpenFAQEvent()),
                child: const Text(
                  "?",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
