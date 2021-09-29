import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/networks/networks_bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key}) : super(key: key);

  Widget _networks(List<NetworkModel> netList) {
    return Column(
      children: [
        for (int i = 0; i < netList.length; i++)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(netList[i].wl_ss_ssid),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepsWidget(),
            const Spacer(),
            Text(AppLocalizations.of(context)!.message4),
            const SizedBox(height: 10),
            BlocBuilder<NetworksBloc, NetworksState>(
              builder: (context, state) {
                if (state is NetworksListState) {
                  return _networks(state.netList);
                }
                // if (state is NetworksListState) {
                return const Center(child: CircularProgressIndicator());
                // }
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.rescan),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
