import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_text.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({Key? key, required this.sec, required this.netList})
      : super(key: key);

  final int sec;
  final List<NetworkModel> netList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoomBody(
        children: [
          const SizedBox(height: 20),
          LoomText(
            AppLocalizations.of(context)!.message4,
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < netList.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  context.read<LoomBloc>().add(
                        LoomNetworksChooseEvent(
                          networkModel: netList[i],
                        ),
                      );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(26, 47, 79, 1),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        netList[i].wl_ss_ssid,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      if (netList[i].wl_ss_sin >= 50)
                        Image.asset("assets/images/wifi3.png", height: 16)
                      else if (netList[i].wl_ss_sin >= 30)
                        Image.asset("assets/images/wifi2.png", height: 16)
                      else
                        Image.asset("assets/images/wifi1.png", height: 16),
                    ],
                  ),
                ),
              ),
            ),
          if (netList.isEmpty) const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 10),
          (sec > 0)
              ? Text("Wait $sec seconds")
              : Align(
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
