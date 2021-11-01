import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0 * devicePixelRatio),
        child: Column(
          children: [
            LoomText(AppLocalizations.of(context)!.message13),
            Expanded(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0 * devicePixelRatio),
                  child: SvgPicture.asset(
                    "assets/images/reset.svg",
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20 * devicePixelRatio),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenInfo1Event()),
              text: AppLocalizations.of(context)!.next,
              loomEvent: LoomClearEvent(),
            ),
            SizedBox(height: 40 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
