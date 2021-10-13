import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class Info1Screen extends StatelessWidget {
  const Info1Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: LoomBody(
        children: [
          LoomText(AppLocalizations.of(context)!.message1),
          Image.asset("assets/images/loom.jpg"),
          const SizedBox(height: 80),
          LoomButton(
            onPressed: () => context.read<LoomBloc>().add(LoomOpenInfo2Event()),
            text: AppLocalizations.of(context)!.next,
            loomEvent: LoomClearEvent(),
          ),
        ],
      ),
    );
  }
}
