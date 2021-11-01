import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_body.dart';
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
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: LoomBody(
        children: [
          LoomAppBar(
            loomEvent: LoomOpenNetworksEvent(),
            text: networkName,
          ),
          LoomText(AppLocalizations.of(context)!.message5, top: 9),
          LoomTextField(
            initialValue: "",
            onChanged: (newValue) => context
                .read<LoomBloc>()
                .add(LoomChangePasswordEvent(data: newValue)),
            labelText: "",
          ),
          SizedBox(height: 10 * devicePixelRatio),
          LoomButton(
            onPressed: () =>
                context.read<LoomBloc>().add(LoomSettingsNextEvent()),
            text: AppLocalizations.of(context)!.next,
            loomEvent: LoomOpenSettingsNetworkEvent(),
          ),
          SizedBox(height: 30 * devicePixelRatio),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              AppLocalizations.of(context)!.message6,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14 * devicePixelRatio,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(130, 135, 158, 1),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                loomName,
                style: TextStyle(
                  fontSize: 14 * devicePixelRatio,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                icon: Image.asset(
                  "assets/images/edit.png",
                  height: 13 * devicePixelRatio,
                ),
                iconSize: 13 * devicePixelRatio,
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: const Color.fromRGBO(10, 22, 52, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0 * devicePixelRatio),
                      ),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: 20 * devicePixelRatio,
                          right: 20 * devicePixelRatio,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10 * devicePixelRatio),
                            LoomText(AppLocalizations.of(context)!.message6_1),
                            SizedBox(height: 15 * devicePixelRatio),
                            LoomTextField(
                              initialValue: loomName,
                              onChanged: (newValue) => context
                                  .read<LoomBloc>()
                                  .add(LoomChangeLoomEvent(data: newValue)),
                              autofocus: true,
                              labelText: "",
                            ),
                            SizedBox(height: 20 * devicePixelRatio),
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
                            SizedBox(height: 20 * devicePixelRatio),
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
    );
  }
}
