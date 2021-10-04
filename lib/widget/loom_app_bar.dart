import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:provider/src/provider.dart';

class LoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  //final Color backgroundColor = Colors.red;
  //final Text title;
  final bool questionMark;

  const LoomAppBar({
    Key? key,
    //required this.title,
    required this.questionMark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return AppBar(
          leading: context.read<NavBloc>().history.isNotEmpty
              ? IconButton(
                  onPressed: () =>
                      context.read<NavBloc>().add(NavPreviousPageEvent()),
                  icon: const Icon(Icons.arrow_back),
                )
              : null,
          title: Row(
            children: const [
              Text("Loom", style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            questionMark
                ? TextButton(
                    onPressed: () => context
                        .read<NavBloc>()
                        .add(NavChangePageEvent(screenNumber: 9)),
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
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
