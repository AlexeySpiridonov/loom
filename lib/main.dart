import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/screens/wait_screen.dart';
import 'bloc/loom/loom_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/info_screen_model.dart';
import 'screens/info_screen.dart';
import 'screens/buttons_connect_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/loom_connect_screen.dart';
import 'screens/networks_screen.dart';
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
            color: Colors.transparent,
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

          if (state is LoomInfoState) {
            return InfoScreen(
              text: infoPagesTexts[state.index],
              nextEvent: state.nextEvent,
            );
          }

          if (state is LoomConnectState) {
            return const LoomConnectScreen();
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
            );
          }

          if (state is LoomWaitState) {
            return const WaitScreen();
          }

          if (state is LoomSuccessfulState) {
            return const SuccessfulScreen();
          }

          if (state is LoomButtonsConnectState) {
            return ButtonsConnectScreen(
              loomName: state.loomName,
              networkName: state.networkName,
            );
          }

          if (state is LoomFAQState) {
            return const FAQScreen();
          }

          // if (state is LoomInitState) {
          return const Center(child: CircularProgressIndicator());
          // }
        }),
      ),
    );
  }
}
