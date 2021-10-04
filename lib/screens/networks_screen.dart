import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/bloc/networks/networks_bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key}) : super(key: key);

  Widget _networks(List<NetworkModel> netList, double width) {
    return Column(
      children: [
        for (int i = 0; i < netList.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              width: width / 2,
              decoration: BoxDecoration(border: Border.all()),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                netList[i].wl_ss_ssid,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
      ],
    );
  }

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
          Text(
            AppLocalizations.of(context)!.message4,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          BlocBuilder<NetworksBloc, NetworksState>(
            builder: (context, state) {
              if (state is NetworksListState) {
                return GestureDetector(
                  onTap: () => context.read<NavBloc>().add(NavNextPageEvent()),
                  child: _networks(
                    state.netList,
                    MediaQuery.of(context).size.width,
                  ),
                );
              }
              // if (state is NetworksListState) {
              return const Center(child: CircularProgressIndicator());
              // }
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () =>
                context.read<NetworksBloc>().add(NetworksGetEvent()),
            child: Text(AppLocalizations.of(context)!.rescan),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
