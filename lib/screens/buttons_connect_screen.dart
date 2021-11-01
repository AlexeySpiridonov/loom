import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonsConnectScreen extends StatelessWidget {
  const ButtonsConnectScreen({
    Key? key,
    required this.loomName,
    required this.networkName,
  }) : super(key: key);

  final String networkName;
  final String loomName;

  ButtonStyle buttonStyle1(double devicePixelRatio) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6 * devicePixelRatio),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 20)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      // elevation: MaterialStateProperty.all(3),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  BoxDecoration boxDecoration1(double devicePixelRatio) {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          Color.fromRGBO(0, 195, 243, 1),
          Color.fromRGBO(21, 98, 216, 1),
        ],
      ),
      color: const Color.fromRGBO(26, 47, 79, 1),
      borderRadius: BorderRadius.circular(6 * devicePixelRatio),
    );
  }

  BoxDecoration boxDecoration2(double devicePixelRatio) {
    return BoxDecoration(
      color: const Color.fromRGBO(26, 47, 79, 1),
      borderRadius: BorderRadius.circular(6 * devicePixelRatio),
    );
  }

  Widget rightPartButton({
    required double devicePixelRatio,
    required VoidCallback onPressed,
    required String text,
  }) {
    return Container(
      decoration: boxDecoration1(devicePixelRatio),
      child: ElevatedButton(
        style: buttonStyle1(devicePixelRatio),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14 * devicePixelRatio),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/wifi3.svg",
                height: 20 * devicePixelRatio,
              ),
              SizedBox(height: 10 * devicePixelRatio),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10 * devicePixelRatio,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wifiButton({
    required double devicePixelRatio,
    required VoidCallback onPressed,
    required String text1,
    required String text2,
    required String textConnect,
    required LoomOpenButtonsEvent loomEvent,
  }) {
    return Container(
      decoration: boxDecoration2(devicePixelRatio),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0 * devicePixelRatio),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16 * devicePixelRatio,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12 * devicePixelRatio),
                  Text(
                    text2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * devicePixelRatio,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 102 * devicePixelRatio,
            child: rightPartButton(
              devicePixelRatio: devicePixelRatio,
              onPressed: onPressed,
              text: textConnect,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * devicePixelRatio),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 56 * devicePixelRatio),
                    SvgPicture.asset(
                      "assets/images/loom.svg",
                      height: 18 * devicePixelRatio,
                    ),
                    SizedBox(height: 11 * devicePixelRatio),
                    Text(
                      AppLocalizations.of(context)!.message19,
                      style: TextStyle(
                        fontSize: 16 * devicePixelRatio,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24 * devicePixelRatio),
                    wifiButton(
                      devicePixelRatio: devicePixelRatio,
                      onPressed: () => context
                          .read<LoomBloc>()
                          .add(LoomConnectNetworkEvent()),
                      text1: AppLocalizations.of(context)!.message14,
                      text2: networkName,
                      textConnect: AppLocalizations.of(context)!.connect,
                      loomEvent: LoomOpenButtonsEvent(),
                    ),
                    SizedBox(height: 16 * devicePixelRatio),
                    wifiButton(
                      devicePixelRatio: devicePixelRatio,
                      onPressed: () =>
                          context.read<LoomBloc>().add(LoomConnectLoomEvent()),
                      text1: AppLocalizations.of(context)!.message15,
                      text2: loomName,
                      textConnect: AppLocalizations.of(context)!.connect,
                      loomEvent: LoomOpenButtonsEvent(),
                    ),
                  ],
                ),
              ),
              LoomButton(
                onPressed: () => context.read<LoomBloc>().add(LoomClearEvent()),
                text: AppLocalizations.of(context)!.message12,
                loomEvent: LoomOpenButtonsEvent(),
                disabled: true,
              ),
              SizedBox(height: 20 * devicePixelRatio),
            ],
          ),
        ),
      ),
    );
  }
}
