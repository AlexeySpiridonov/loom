import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_body.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class Info3Screen extends StatelessWidget {
  const Info3Screen({
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
          LoomText(AppLocalizations.of(context)!.message3),
          Image.asset("assets/images/loom.jpg"),
          const SizedBox(height: 80),
          LoomButton(
            onPressed: () =>
                context.read<LoomBloc>().add(LoomOpenConnectEvent()),
            text: AppLocalizations.of(context)!.light_on,
            loomEvent: LoomClearEvent(),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(26, 47, 79, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 20)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenResetEvent()),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
