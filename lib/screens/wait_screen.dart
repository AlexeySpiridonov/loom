import 'package:flutter/material.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          const SizedBox(height: 80),
          Text(AppLocalizations.of(context)!.message7),
          const SizedBox(height: 30),
          const CircularProgressIndicator(),
          const SizedBox(height: 30),
          Text(AppLocalizations.of(context)!.message8),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
