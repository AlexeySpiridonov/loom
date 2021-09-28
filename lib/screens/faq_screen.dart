import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:loom/widget/steps_widget.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  final List<String> results = const [
    "1. ****************",
    "2. ****************",
    "3. ****************",
    "4. ****************",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            const Text(
              "Решение проблем:",
              style: TextStyle(
                fontSize: 24,
                height: 2,
              ),
            ),
            for (int i = 0; i < results.length; i++)
              Text(
                results[i],
                style: const TextStyle(
                  fontSize: 24,
                  height: 2,
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
