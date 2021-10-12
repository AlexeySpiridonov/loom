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
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          LoomText(
            AppLocalizations.of(context)!.message16,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LoomTextField(
              initialValue: "",
              onChanged: (newValue) => context
                  .read<LoomBloc>()
                  .add(LoomChangeNetworkEvent(data: newValue)),
              labelText: "Wi-Fi address",
            ),
          ),
          const SizedBox(height: 20),
          LoomButton(
            onPressed: () {
              context.read<LoomBloc>().add(LoomTryConnectEvent());
            },
            text: AppLocalizations.of(context)!.connect,
            loomEvent: LoomOpenConnectEvent(),
          ),
          const SizedBox(height: 20),
          (error != "" && error != "successful") ? Text(error) : Container(),
        ],
      ),
    );
  }
}
