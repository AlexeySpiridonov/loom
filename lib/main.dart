import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/screens/info2_screen.dart';
import 'package:loom/screens/wait_screen.dart';
import 'bloc/loom/loom_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/info_screen_model.dart';
import 'screens/info1_screen.dart';
import 'screens/buttons_connect_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/info3_screen.dart';
import 'screens/loom_connect_screen.dart';
import 'screens/networks_screen.dart';
import 'screens/reset_screen.dart';
import 'screens/settings_network_screen.dart';
import 'screens/successful_screen.dart';
import 'services/http_api_provider.dart';
import 'services/wifi_api_provider.dart';

void main() {
  runApp(const MyApp());
}

late List<String> infoPagesTexts;
late List<InfoScreenModel> infoScreenModels;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpApiProvider httpApiProvider = HttpApiProvider();
    WifiApiProvider wifiApiProvider = WifiApiProvider();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoomBloc>(
          create: (BuildContext context) => LoomBloc(
            wifiApiProvider: wifiApiProvider,
            httpApiProvider: httpApiProvider,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Aj',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: L10n.all,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromRGBO(10, 22, 52, 1),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: BlocBuilder<LoomBloc, LoomState>(builder: (context, state) {
          infoPagesTexts = [
            AppLocalizations.of(context)!.message1,
            AppLocalizations.of(context)!.message2,
            AppLocalizations.of(context)!.message3,
            //const LoomConnectScreen(),
            //const NetworksScreen(),
            //const SettingsNetworkScreen(),
            //AppLocalizations.of(context)!.message9,
            //const ButtonsConnectScreen(),
            //const FAQScreen(),
            AppLocalizations.of(context)!.message13,
          ];

          if (state is LoomInfo1State) {
            return const Info1Screen();
          }
          if (state is LoomInfo2State) {
            return const Info2Screen();
          }
          if (state is LoomInfo3State) {
            return const Info3Screen();
          }

          if (state is LoomConnectState) {
            return LoomConnectScreen(error: state.error);
          }

          if (state is LoomNetworksState) {
            return NetworksScreen(
              sec: state.sec,
              netList: state.netList,
            );
          }

          if (state is LoomSettingsNetworkState) {
            return SettingsNetworkScreen(
              networkName: state.networkName,
              loomName: state.loomName,
            );
          }

          if (state is LoomWaitState) {
            return WaitScreen(
              sec: state.sec,
              messageId: state.messageId,
            );
          }

          if (state is LoomSuccessfulState) {
            return SuccessfulScreen(
              networkName: state.networkName,
              loomName: state.loomName,
            );
          }

          if (state is LoomButtonsConnectState) {
            return ButtonsConnectScreen(
              loomName: state.loomName,
              networkName: state.networkName,
            );
          }

          if (state is LoomFAQState) {
            return FAQScreen(loomEvent: state.loomEvent);
          }

          if (state is LoomResetState) {
            return const ResetScreen();
          }

          // if (state is LoomInitState) {
          return const WaitScreen(sec: 0, messageId: 0);
          // }
        }),
      ),
    );
  }
}
