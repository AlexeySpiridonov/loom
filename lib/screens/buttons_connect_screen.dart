import 'package:flutter/material.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonsConnectScreen extends StatelessWidget {
  const ButtonsConnectScreen({
    Key? key,
    required this.loomName,
    required this.networkName,
  }) : super(key: key);

  final String networkName;
  final String loomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomConnectNetworkEvent()),
              text: "${AppLocalizations.of(context)!.message10} $networkName",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomConnectLoomEvent()),
              text: "${AppLocalizations.of(context)!.message11} $loomName",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () => context.read<LoomBloc>().add(LoomClearEvent()),
              text: AppLocalizations.of(context)!.message12,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
