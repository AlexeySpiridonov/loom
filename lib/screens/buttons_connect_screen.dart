import 'package:flutter/material.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonsConnectScreen extends StatelessWidget {
  const ButtonsConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const StepsWidget(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              text: AppLocalizations.of(context)!.message10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              text: AppLocalizations.of(context)!.message11,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoomButton(
              onPressed: () => context.read<NavBloc>().add(NavClearEvent()),
              text: AppLocalizations.of(context)!.message12,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
