import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';
import 'package:loom/widget/loom_text_field.dart';

class LoomConnectScreen extends StatelessWidget {
  const LoomConnectScreen({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: LoomBody(
        children: [
          LoomText(
            AppLocalizations.of(context)!.message16,
          ),
          SizedBox(height: 10 * devicePixelRatio),
          LoomTextField(
            initialValue: "",
            onChanged: (newValue) => context
                .read<LoomBloc>()
                .add(LoomChangeNetworkEvent(data: newValue)),
            labelText: "Wi-Fi address",
          ),
          SizedBox(height: 20 * devicePixelRatio),
          LoomButton(
            onPressed: () {
              context.read<LoomBloc>().add(LoomTryConnectEvent());
            },
            text: AppLocalizations.of(context)!.connect,
            loomEvent: LoomOpenConnectEvent(),
          ),
          SizedBox(height: 20 * devicePixelRatio),
          (error != "" && error != "successful") ? Text(error) : Container(),
        ],
      ),
    );
  }
}
