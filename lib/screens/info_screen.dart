import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:loom/widget/loom_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:loom/bloc/nav/nav_bloc.dart';
import '../widget/steps_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoomAppBar(
        questionMark: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const StepsWidget(),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
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
                      context.read<NavBloc>().add(NavNextPageEvent()),
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
