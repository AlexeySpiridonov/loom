import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);

  final int error;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    Map<int, String> errors = {
      101: AppLocalizations.of(context)!.error101,
      102: AppLocalizations.of(context)!.error102,
      103: AppLocalizations.of(context)!.error103,
      104: AppLocalizations.of(context)!.error104,
    };

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0 * devicePixelRatio),
        child: Column(
          children: [
            (errors[error] != null)
                ? LoomText("$error ${errors[error]}")
                : LoomText(AppLocalizations.of(context)!.error),
            Expanded(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0 * devicePixelRatio),
                  child: Image.asset("assets/images/info3.jpg"),
                ),
              ),
            ),
            SizedBox(height: 60 * devicePixelRatio),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenInfo2Event()),
              text: AppLocalizations.of(context)!.next,
              loomEvent: LoomOpenInfo1Event(),
            ),
            SizedBox(height: 40 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
