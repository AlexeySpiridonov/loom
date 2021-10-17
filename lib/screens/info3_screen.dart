import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class Info3Screen extends StatelessWidget {
  const Info3Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0 * devicePixelRatio),
        child: Column(
          children: [
            LoomText(AppLocalizations.of(context)!.message3),
            Expanded(
              child: Center(
                child: Image.asset("assets/images/info3.jpg"),
              ),
            ),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenConnectEvent()),
              text: AppLocalizations.of(context)!.light_on,
              loomEvent: LoomOpenInfo3Event(),
            ),
            SizedBox(height: 12 * devicePixelRatio),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenResetEvent()),
              text: AppLocalizations.of(context)!.no,
              loomEvent: LoomOpenInfo3Event(),
              disabled: true,
            ),
            SizedBox(height: 20 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
