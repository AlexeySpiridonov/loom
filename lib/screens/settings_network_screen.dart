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
  const SettingsNetworkScreen({
    Key? key,
    required this.networkName,
    required this.loomName,
  }) : super(key: key);

  final String networkName;
  final String loomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoomAppBar(
        loomEvent: LoomOpenNetworksEvent(),
        questionMark: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
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
                  context.read<LoomBloc>().add(LoomSettingsNextEvent()),
              text: AppLocalizations.of(context)!.next,
              loomEvent: LoomOpenSettingsNetworkEvent(),
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
                  loomName,
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
                      backgroundColor: const Color.fromRGBO(10, 22, 52, 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              LoomText(AppLocalizations.of(context)!.message6),
                              const SizedBox(height: 15),
                              LoomTextField(
                                initialValue: loomName,
                                onChanged: (newValue) => context
                                    .read<LoomBloc>()
                                    .add(LoomChangeLoomEvent(data: newValue)),
                                autofocus: true,
                                labelText: "",
                              ),
                              const SizedBox(height: 20),
                              LoomButton(
                                onPressed: () {
                                  context
                                      .read<LoomBloc>()
                                      .add(LoomSettingsSaveEvent());
                                  Navigator.pop(context);
                                },
                                text: AppLocalizations.of(context)!.save,
                                loomEvent: LoomOpenSettingsNetworkEvent(),
                                isModalBottomSheet: true,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
