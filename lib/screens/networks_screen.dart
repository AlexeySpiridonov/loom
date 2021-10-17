import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_text.dart';
import 'package:loom/widget/loom_wifi_button.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key, required this.sec, required this.netList})
      : super(key: key);

  final int sec;
  final List<NetworkModel> netList;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: LoomBody(
        children: [
          SizedBox(height: 20 * devicePixelRatio),
          LoomText(
            AppLocalizations.of(context)!.message4,
          ),
          SizedBox(height: 20 * devicePixelRatio),
          for (int i = 0; i < netList.length; i++)
            LoomWifiButton(networkModel: netList[i]),
          //if (netList.isEmpty) const Center(child: Text("empty list")),
          SizedBox(height: 10 * devicePixelRatio),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomNetworksGetEvent()),
              child: Text(AppLocalizations.of(context)!.rescan),
            ),
          ),
        ],
      ),
    );
  }
}
