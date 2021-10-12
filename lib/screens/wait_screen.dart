import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({
    Key? key,
    required this.sec,
    required this.messageId,
  }) : super(key: key);

  final int sec;
  final int messageId;

  @override
  Widget build(BuildContext context) {
    List<String> messages = [
      "",
      AppLocalizations.of(context)!.message17,
      AppLocalizations.of(context)!.message18,
      AppLocalizations.of(context)!.message8,
    ];

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
          const SizedBox(height: 10),
          (sec > 0) ? Text("Wait $sec seconds") : Container(),
          const SizedBox(height: 30),
          Text(messages[messageId]),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
