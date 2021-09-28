import 'package:flutter/material.dart';
import 'package:loom/widget/steps_widget.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key}) : super(key: key);

  Widget _networks() {
    return Column(
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("NetworkName"),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            const Text("Выберите вашу домашнюю сеть:"),
            const SizedBox(height: 10),
            _networks(),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text("Rescan"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
