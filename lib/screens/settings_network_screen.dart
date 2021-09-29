import 'package:flutter/material.dart';
import 'package:loom/widget/loom_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsNetworkScreen extends StatelessWidget {
  const SettingsNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            LoomButton(
              onPressed: () {},
              text: "test",
            ),
            Text(AppLocalizations.of(context)!.message5),
            LoomButton(
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              text: AppLocalizations.of(context)!.next,
            ),
            Text(AppLocalizations.of(context)!.message6),
            TextFormField(
              initialValue: "myHomeNet-R",
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            LoomButton(
              onPressed: () => context.read<NavBloc>().add(NavNextPageEvent()),
              text: AppLocalizations.of(context)!.change,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
