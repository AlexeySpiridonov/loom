import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/bloc/networks/networks_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NetworksBloc>().add(NetworksGetEvent());
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: BlocBuilder<NetworksBloc, NetworksState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const StepsWidget(),
                  Text(
                    AppLocalizations.of(context)!.message4,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  if (state is NetworksListState)
                    for (int i = 0; i < state.netList.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: GestureDetector(
                          onTap: () {
                            context.read<NetworksBloc>().add(
                                  NetworksChooseEvent(
                                    networkModel: state.netList[i],
                                  ),
                                );
                            context.read<NavBloc>().add(NavNextPageEvent());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${state.netList[i].wl_ss_ssid} - ${state.netList[i].wl_ss_sin}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                  else
                    const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 10),
                  (state is NetworksWaitState)
                      ? Text("Wait ${state.sec} seconds")
                      : TextButton(
                          onPressed: () => context
                              .read<NetworksBloc>()
                              .add(NetworksGetEvent()),
                          child: Text(AppLocalizations.of(context)!.rescan),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
