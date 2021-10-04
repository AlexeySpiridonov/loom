import 'package:flutter/material.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/src/provider.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> results = [
      AppLocalizations.of(context)!.faq1,
      AppLocalizations.of(context)!.faq2,
      AppLocalizations.of(context)!.faq3,
      AppLocalizations.of(context)!.faq4,
    ];

    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: false,
      ),
      body: Column(
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
    );
  }
}
