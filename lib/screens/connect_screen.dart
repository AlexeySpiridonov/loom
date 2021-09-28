import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifi_app/bloc/nav/nav_bloc.dart';
import 'package:wifi_app/widget/steps_widget.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(150, 2)),
              ),
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              child: const Text(
                "Подключиться к домашней сети  myHomeNet [>]",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(150, 2)),
              ),
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              child: const Text(
                "Подключиться к сети Loom: myHomeNet-R [>]",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(150, 2)),
              ),
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              child: const Text(
                "[настроить другой Loom]",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
