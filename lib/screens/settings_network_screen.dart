import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/settings/settings_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
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
    context.read<SettingsBloc>().add(SettingsGetNetworkNameEvent());
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSuccessSaveState) {
            context.read<NavBloc>().add(NavNextPageEvent());
          }
        },
        builder: (context, state) {
          if (state is SettingsWaitState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StepsWidget(),
                const Spacer(),
                Text(AppLocalizations.of(context)!.message7),
                const CircularProgressIndicator(),
                Text(AppLocalizations.of(context)!.message8),
                const Spacer(),
              ],
            );
          }
          if (state is SettingsEditState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StepsWidget(),
                const Spacer(),
                Text(
                    "${AppLocalizations.of(context)!.message5} ${state.networkName}"),
                TextFormField(
                  initialValue: "",
                  onChanged: (newValue) => context
                      .read<SettingsBloc>()
                      .add(SettingsPasswordChangeEvent(data: newValue)),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                Text(AppLocalizations.of(context)!.message6),
                TextFormField(
                  initialValue: state.networkName + "-plus",
                  onChanged: (newValue) => context
                      .read<SettingsBloc>()
                      .add(SettingsLoomNameChangeEvent(data: newValue)),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                LoomButton(
                  onPressed: () =>
                      context.read<SettingsBloc>().add(SettingsSaveEvent()),
                  text: AppLocalizations.of(context)!.save,
                ),
                const Spacer(),
              ],
            );
          }
          //if (state is SettingsInitState) {
          return const Center(child: CircularProgressIndicator());
          //}
        },
      ),
    );
  }
}
