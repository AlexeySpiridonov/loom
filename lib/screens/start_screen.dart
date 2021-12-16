import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loom/widget/loom_text.dart';
import 'package:loom/widget/loom_text_field.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40.0 * devicePixelRatio),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              LoomText(AppLocalizations.of(context)!.enter_email),
              LoomTextField(
                onChanged: (String newValue) {
                  context
                      .read<LoomBloc>()
                      .add(LoomChangeEmailEvent(email: newValue));
                },
                initialValue: email,
                labelText: 'E-Mail',
                validator: (value) => EmailValidator.validate(value ?? "")
                    ? null
                    : AppLocalizations.of(context)!.valid_email,
              ),
              SizedBox(height: 14 * devicePixelRatio),
              LoomButton(
                onPressed: () =>
                    context.read<LoomBloc>().add(LoomSendEmailEvent()),
                text: AppLocalizations.of(context)!.next,
                loomEvent: LoomOpenStartEvent(),
                nofaq: true,
              ),
              SizedBox(height: 40 * devicePixelRatio),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.0 * devicePixelRatio),
                    child: SvgPicture.asset(
                      "assets/images/start.svg",
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40 * devicePixelRatio),
            ],
          ),
        ),
      ),
    );
  }
}
