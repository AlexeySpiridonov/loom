import 'package:flutter/material.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            Text(AppLocalizations.of(context)!.message7),
            const CircularProgressIndicator(),
            Text(AppLocalizations.of(context)!.message8),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
