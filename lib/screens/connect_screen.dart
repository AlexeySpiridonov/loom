import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:loom/widget/steps_widget.dart';
import '../bloc/wifi/wifi_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const StepsWidget(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                initialValue: "",
                onChanged: (newValue) => context
                    .read<WifiBloc>()
                    .add(WifiLoginChangeEvent(data: newValue)),
                decoration: InputDecoration(
                  labelText: "Network name",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                initialValue: "",
                onChanged: (newValue) => context
                    .read<WifiBloc>()
                    .add(WifiPasswordChangeEvent(data: newValue)),
                decoration: InputDecoration(
                  labelText: "Network password",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocConsumer<WifiBloc, WifiState>(
              listener: (context, state) {
                if (state is WifiConnectedState) {
                  context.read<NavBloc>().add(NavNextPageEvent());
                }
              },
              builder: (context, state) {
                if (state is WifiConnectedState) {
                  return Text(state.result);
                }
                return const Text("nothing");
              },
            ),
            const SizedBox(height: 10),
            LoomButton(
              onPressed: () {
                context.read<WifiBloc>().add(WifiConnectEvent());
              },
              text: AppLocalizations.of(context)!.connect,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
