import 'package:flutter/material.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';

class WaitTimerScreen extends StatelessWidget {
  const WaitTimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          Text(AppLocalizations.of(context)!.message7),
          const CircularProgressIndicator(),
          Text(AppLocalizations.of(context)!.message8),
        ],
      ),
    );
  }
}
