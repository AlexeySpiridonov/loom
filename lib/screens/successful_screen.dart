import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({
    Key? key,
    required this.networkName,
    required this.loomName,
  }) : super(key: key);

  final String networkName;
  final String loomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          const SizedBox(height: 80),
          Text(
            """${AppLocalizations.of(context)!.message9_1} $networkName
${AppLocalizations.of(context)!.message9_2} $loomName
${AppLocalizations.of(context)!.message9_3}""",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 2,
            ),
          ),
          const SizedBox(height: 20),
          LoomButton(
            onPressed: () =>
                context.read<LoomBloc>().add(LoomOpenButtonsEvent()),
            text: AppLocalizations.of(context)!.next,
            loomEvent: LoomOpenSuccessfulEvent(),
          ),
        ],
      ),
    );
  }
}