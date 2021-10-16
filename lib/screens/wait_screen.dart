import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_body.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({
    Key? key,
    required this.sec,
    required this.messageId,
  }) : super(key: key);

  final int sec;
  final int messageId;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;
    final List<String> messages = [
      "",
      AppLocalizations.of(context)!.message17,
      AppLocalizations.of(context)!.message18,
      AppLocalizations.of(context)!.message8,
    ];

    return Scaffold(
      body: LoomBody(
        children: [
          SizedBox(height: 80 * devicePixelRatio),
          Text(
            messages[messageId],
            style: TextStyle(
              fontSize: 16 * devicePixelRatio,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30 * devicePixelRatio),
          SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 3.0 * devicePixelRatio,
            ),
            height: 80 * devicePixelRatio,
            width:  80 * devicePixelRatio,
          ),
          SizedBox(height: 40 * devicePixelRatio),
          (sec > 0)
              ? Text(
                  "$sec",
                  style: TextStyle(
                    fontSize: 16 * devicePixelRatio,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Container(),
          SizedBox(height: 80 * devicePixelRatio),
        ],
      ),
    );
  }
}
