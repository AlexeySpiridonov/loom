import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/services/logger.dart';
import 'package:loom/widget/loom_body.dart';
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
      105: AppLocalizations.of(context)!.error105,
    };

    return Scaffold(
      body: LoomBody(
        children: [
          SizedBox(height: 60 * devicePixelRatio),
          (errors[error] != null)
              ? LoomText("$error ${errors[error]}")
              : LoomText(AppLocalizations.of(context)!.error),
          SizedBox(height: 60 * devicePixelRatio),
          LoomButton(
            onPressed: () => context.read<LoomBloc>().add(LoomOpenInfo1Event()),
            text: AppLocalizations.of(context)!.startAnew,
            loomEvent: LoomOpenInfo1Event(),
            nofaq: true,
          ),
          //const LoomText("Logs:"),
          //LoomText(
          //  allLogs,
          //  top: 0,
          //  textSize: 10,
          //),
          SizedBox(height: 40 * devicePixelRatio),
        ],
      ),
    );
  }
}
