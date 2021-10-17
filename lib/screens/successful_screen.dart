import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
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
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    final textStyle1 = TextStyle(
      fontSize: 18 * devicePixelRatio,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
    final textStyle2 = TextStyle(
      fontSize: 14 * devicePixelRatio,
      fontWeight: FontWeight.w400,
      color: const Color.fromRGBO(255, 255, 255, 0.4),
      height: 1.4,
    );
    final textStyle3 = TextStyle(
      fontSize: 16 * devicePixelRatio,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 52.0 * devicePixelRatio,
                  bottom: 37.0 * devicePixelRatio,
                ),
                child: Column(children: [
                  Text(
                    AppLocalizations.of(context)!.message9_1,
                    textAlign: TextAlign.start,
                    style: textStyle1,
                  ),
                  SizedBox(height: 25.0 * devicePixelRatio),
                  Text(
                    AppLocalizations.of(context)!.message9_2,
                    textAlign: TextAlign.start,
                    style: textStyle2,
                  ),
                  SizedBox(height: 2.0 * devicePixelRatio),
                  Text(
                    networkName,
                    textAlign: TextAlign.start,
                    style: textStyle3,
                  ),
                  SizedBox(height: 25.0 * devicePixelRatio),
                  Text(
                    AppLocalizations.of(context)!.message9_3,
                    textAlign: TextAlign.start,
                    style: textStyle2,
                  ),
                  SizedBox(height: 2.0 * devicePixelRatio),
                  Text(
                    loomName,
                    textAlign: TextAlign.start,
                    style: textStyle3,
                  ),
                  SizedBox(height: 25.0 * devicePixelRatio),
                  Text(
                    AppLocalizations.of(context)!.message9_4,
                    textAlign: TextAlign.start,
                    style: textStyle3,
                  ),
                ]),
              ),
            ),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenButtonsEvent()),
              text: AppLocalizations.of(context)!.perfectly,
              loomEvent: LoomOpenSuccessfulEvent(),
            ),
            SizedBox(height: 20.0 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
