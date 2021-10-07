import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const LoomAppBar(
      //   questionMark: true,
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.message9,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/loom.jpg"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: LoomButton(
                  onPressed: () =>
                      context.read<LoomBloc>().add(LoomOpenButtonsEvent()),
                  text: AppLocalizations.of(context)!.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
