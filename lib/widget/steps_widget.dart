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
                  GestureDetector(
                    onTap: () => context
                        .read<NavBloc>()
                        .add(NavChangePageEvent(screenNumber: i)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(
                        child: Container(
                          color: state.screenNumber == i
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          width: 15,
                          height: 15,
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
