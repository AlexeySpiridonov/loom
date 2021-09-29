import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/nav/nav_bloc.dart';
import 'bloc/networks/networks_bloc.dart';
import 'bloc/wifi/wifi_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens/buttons_connect_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/info_screen.dart';
import 'screens/connect_screen.dart';
import 'screens/networks_screen.dart';
import 'screens/settings_network_screen.dart';
import 'screens/wait_screen.dart';
import 'services/http_api_provider.dart';

void main() {
  runApp(const MyApp());
}

late List<Widget> screens;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WifiBloc>(
          create: (BuildContext context) => WifiBloc(),
        ),
        BlocProvider<NavBloc>(
          create: (BuildContext context) => NavBloc(),
        ),
        BlocProvider<NetworksBloc>(
          create: (BuildContext context) =>
              NetworksBloc(httpApiProvider: HttpApiProvider()),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        title: 'Aj',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: L10n.all,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromRGBO(229, 239, 240, 1),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          primarySwatch: Colors.cyan,
        ),
        home: BlocBuilder<NavBloc, NavState>(builder: (context, state) {
          screens = [
            InfoScreen(text: AppLocalizations.of(context)!.message1),
            InfoScreen(text: AppLocalizations.of(context)!.message2),
            InfoScreen(text: AppLocalizations.of(context)!.message3),
            const ConnectScreen(),
            const NetworksScreen(),
            const SettingsNetworkScreen(),
            const WaitScreen(),
            InfoScreen(text: AppLocalizations.of(context)!.message9),
            const ButtonsConnectScreen(),
            const FAQScreen(),
            InfoScreen(text: AppLocalizations.of(context)!.message13),
          ];

          if (state is NavScreenState) {
            return screens[state.screenNumber];
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
