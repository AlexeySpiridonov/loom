import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';

class LoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LoomEvent loomEvent;
  final bool questionMark;
  final String text;

  const LoomAppBar({
    Key? key,
    required this.questionMark,
    required this.loomEvent,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.read<LoomBloc>().add(loomEvent),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
