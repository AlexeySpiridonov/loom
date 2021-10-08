import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    Key? key,
    required this.text,
    required this.nextEvent,
  }) : super(key: key);

  final String text;
  final LoomEvent nextEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          const SizedBox(height: 80),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("assets/images/loom.jpg"),
          const SizedBox(height: 80),
          LoomButton(
            onPressed: () => context.read<LoomBloc>().add(nextEvent),
            text: AppLocalizations.of(context)!.next,
            loomEvent: LoomClearEvent(),
          ),
        ],
      ),
    );
  }
}
