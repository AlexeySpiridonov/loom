import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

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
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: LoomBody(
        children: [
          LoomText(
            """
            ${AppLocalizations.of(context)!.message9_1}
            ${AppLocalizations.of(context)!.message9_2} $networkName
            ${AppLocalizations.of(context)!.message9_3} $loomName
            ${AppLocalizations.of(context)!.message9_4}
            """,
          ),
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
