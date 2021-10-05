import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom_connect/loom_connect_bloc.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:loom/widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoomConnectScreen extends StatelessWidget {
  const LoomConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocListener<LoomConnectBloc, LoomConnectState>(
      listener: (context, state) {
        if (state is LoomConnectSuccessfulState) {
          print("he");
          context.read<NavBloc>().add(NavNextPageEvent());
        }
      },
    );
    context.read<LoomConnectBloc>().add(LoomConnectTryEvent());
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: Column(
        children: [
          const StepsWidget(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              initialValue: "",
              onChanged: (newValue) => context
                  .read<LoomConnectBloc>()
                  .add(LoomConnectLoginChangeEvent(data: newValue)),
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
          const SizedBox(height: 10),
          LoomButton(
            onPressed: () {
              context.read<LoomConnectBloc>().add(LoomConnectTryEvent());
            },
            text: AppLocalizations.of(context)!.connect,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
