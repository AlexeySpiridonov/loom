import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:loom/widget/loom_text.dart';
import 'package:loom/widget/loom_text_field.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsNetworkScreen extends StatelessWidget {
  const SettingsNetworkScreen({Key? key, required this.networkName})
      : super(key: key);

  final String networkName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoomAppBar(
        loomEvent: LoomOpenNetworksEvent(),
        questionMark: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            LoomText(AppLocalizations.of(context)!.message5),
            const SizedBox(height: 20),
            LoomTextField(
              initialValue: "",
              onChanged: (newValue) => context
                  .read<LoomBloc>()
                  .add(LoomChangePasswordEvent(data: newValue)),
              labelText: "",
            ),
            const SizedBox(height: 10),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomSettingsSaveEvent()),
              text: AppLocalizations.of(context)!.next,
            ),
            const SizedBox(
              height: 24,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Wi-Fi name for Loom",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(130, 135, 158, 1),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "$networkName-plus",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/images/edit.png",
                    height: 20,
                  ),
                  iconSize: 20,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          padding: MediaQuery.of(context).viewInsets,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                LoomText(
                                    AppLocalizations.of(context)!.message6),
                                const SizedBox(height: 10),
                                LoomTextField(
                                  initialValue: networkName + "-plus",
                                  onChanged: (newValue) => context
                                      .read<LoomBloc>()
                                      .add(LoomChangeLoomEvent(data: newValue)),
                                  labelText: "",
                                ),
                                const SizedBox(height: 20),
                                LoomButton(
                                  onPressed: () => context
                                      .read<LoomBloc>()
                                      .add(LoomSettingsSaveEvent()),
                                  text: AppLocalizations.of(context)!.save,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
