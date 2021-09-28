import 'package:flutter/material.dart';
import 'package:loom/widget/steps_widget.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            StepsWidget(),
            Spacer(),
            Text("Ожидайте…."),
            CircularProgressIndicator(),
            Text(
                "Приложение запросит подключение к домашней сети и сети репитера, разрешите это действие"),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
