import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';

import '../main.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        if (state is NavScreenState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (int i = 0; i < screens.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context
                          .read<NavBloc>()
                          .add(NavChangePageEvent(screenNumber: i)),
                      child: CircleAvatar(
                        backgroundColor: state.screenNumber == i
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        child: Text(
                          (i + 1).toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
