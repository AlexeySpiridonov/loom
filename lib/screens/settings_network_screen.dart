import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifi_app/bloc/nav/nav_bloc.dart';
import 'package:wifi_app/widget/steps_widget.dart';

class SettingsNetworkScreen extends StatelessWidget {
  const SettingsNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            const Text("Введите пароль от домашней сети myHomeNet"),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(150, 2)),
              ),
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              child: const Text(
                "Далее",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const Text("Сеть Loom будет называться:"),
            TextFormField(
              initialValue: "myHomeNet-R",
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(150, 2)),
              ),
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              child: const Text(
                "Поменять",
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
