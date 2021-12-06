import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
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
            LoomText(AppLocalizations.of(context)!.enter_email),
            SizedBox(height: 60 * devicePixelRatio),
            TextFormField(
              onChanged: (String newValue) {
                context
                    .read<LoomBloc>()
                    .add(LoomChangeEmailEvent(email: newValue));
              },
            ),
            SizedBox(height: 60 * devicePixelRatio),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomSendEmailEvent()),
              text: AppLocalizations.of(context)!.next,
              loomEvent: LoomOpenStartEvent(),
              nofaq: true,
            ),
            SizedBox(height: 40 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
