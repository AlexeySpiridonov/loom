import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({
    Key? key,
    required this.rate,
  }) : super(key: key);

  final int rate;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0 * devicePixelRatio),
        child: Column(
          children: [
            SizedBox(height: 60 * devicePixelRatio),
            LoomText(
              AppLocalizations.of(context)!.please_rate,
              top: 15,
              bottom: 15,
            ),
            RatingBar.builder(
              initialRating: rate.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double rating) {
                context
                    .read<LoomBloc>()
                    .add(LoomSetRatingEvent(rating: rating));
              },
            ),
            SizedBox(height: 15 * devicePixelRatio),
            Expanded(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0 * devicePixelRatio),
                  child: SvgPicture.asset(
                    "assets/images/pic_done.svg",
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20 * devicePixelRatio),
            LoomText(
              AppLocalizations.of(context)!.message9_4,
              top: 0,
              bottom: 15,
            ),
            SizedBox(height: 20 * devicePixelRatio),
            LoomButton(
              onPressed: (rate != 0)
                  ? () => context.read<LoomBloc>().add(LoomSendRatingEvent())
                  : () {},
              text: AppLocalizations.of(context)!.finish,
              loomEvent: LoomOpenSuccessfulEvent(),
              nofaq: true,
              disabled: rate == 0,
            ),
            SizedBox(height: 40 * devicePixelRatio),
          ],
        ),
      ),
    );
  }
}
