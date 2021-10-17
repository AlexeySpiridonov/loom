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

    final textStyle1 = TextStyle(
      fontSize: 18 * devicePixelRatio,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
    final textStyle2 = TextStyle(
      fontSize: 18 * devicePixelRatio,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
    final textStyle3 = TextStyle(
      fontSize: 18 * devicePixelRatio,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );

    return Scaffold(
      body: LoomBody(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 52.0 * devicePixelRatio,
              bottom: 37.0 * devicePixelRatio,
            ),
            child: Column(children: [
              Text(AppLocalizations.of(context)!.message9_1,
                  textAlign: TextAlign.start, style: textStyle1),
              Text(AppLocalizations.of(context)!.message9_2,
                  textAlign: TextAlign.start, style: textStyle2),
              Text(networkName, textAlign: TextAlign.start, style: textStyle3),
              Text(AppLocalizations.of(context)!.message9_3,
                  textAlign: TextAlign.start, style: textStyle2),
              Text(loomName, textAlign: TextAlign.start, style: textStyle3),
              Text(AppLocalizations.of(context)!.message9_4,
                  textAlign: TextAlign.start, style: textStyle2),
            ]),
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
