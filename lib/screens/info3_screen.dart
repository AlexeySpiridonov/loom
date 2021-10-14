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
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: LoomBody(
        children: [
          LoomText(AppLocalizations.of(context)!.message3),
          Image.asset("assets/images/loom.jpg"),
          SizedBox(height: 20 * devicePixelRatio),
          LoomButton(
            onPressed: () =>
                context.read<LoomBloc>().add(LoomOpenConnectEvent()),
            text: AppLocalizations.of(context)!.light_on,
            loomEvent: LoomOpenInfo3Event(),
          ),
          SizedBox(height: 12 * devicePixelRatio),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(26, 47, 79, 1),
              borderRadius: BorderRadius.circular(6 * devicePixelRatio),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6 * devicePixelRatio),
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
                padding: EdgeInsets.symmetric(
                  vertical: 10 * devicePixelRatio,
                ),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * devicePixelRatio,
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
