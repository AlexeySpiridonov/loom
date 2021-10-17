import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class Info2Screen extends StatelessWidget {
  const Info2Screen({
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
            LoomText(AppLocalizations.of(context)!.message2),
            Expanded(
              child: Center(
                child: Image.asset("assets/images/info2.jpg"),
              ),
            ),
            LoomButton(
              onPressed: () =>
                  context.read<LoomBloc>().add(LoomOpenInfo3Event()),
              text: AppLocalizations.of(context)!.next,
              loomEvent: LoomOpenInfo2Event(),
            ),
            SizedBox(height: 40 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
