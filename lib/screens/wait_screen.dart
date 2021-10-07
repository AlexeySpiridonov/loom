import 'package:flutter/material.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(AppLocalizations.of(context)!.message7),
          const CircularProgressIndicator(),
          Text(AppLocalizations.of(context)!.message8),
          const Spacer(),
        ],
      ),
    );
  }
}
