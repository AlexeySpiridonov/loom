import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/nav/nav_bloc.dart';
import 'bloc/wifi/wifi_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens_data.dart';

void main() {
  runApp(const MyApp());
}

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
          if (state is NavScreenState) {
            return screens[state.screenNumber];
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
