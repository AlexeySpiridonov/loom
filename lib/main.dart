import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loom/screens/info2_screen.dart';
import 'package:loom/screens/start_screen.dart';
import 'package:loom/screens/wait_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'bloc/loom/loom_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/info_screen_model.dart';
import 'screens/error_screen.dart';
import 'screens/info1_screen.dart';
import 'screens/buttons_connect_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/info3_screen.dart';
import 'screens/loom_connect_screen.dart';
import 'screens/networks_screen.dart';
import 'screens/reset106_screen.dart';
import 'screens/reset_screen.dart';
import 'screens/settings_network_screen.dart';
import 'screens/successful_screen.dart';
import 'services/firebase_analytics_service.dart';
import 'services/http_api_provider.dart';
import 'services/service_locator.dart';
import 'services/wifi_api_provider.dart';

bool debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  remoteConfig = RemoteConfig.instance;
  remoteConfig.setDefaults(<String, dynamic>{
    'enter_email': false,
    'debug': true,
  });
  await remoteConfig.fetch();

  debug = remoteConfig.getBool('debug');

  setUp();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7ed315a456974a05b63872cd8e3098f8@o1091458.ingest.sentry.io/6108407';
      options.tracesSampleRate = 1.0;
      options.release = 'wifi-set@1.0.8+8';
      options.environment = 'prod';
    },
    appRunner: () => runApp(const MyApp()),
  );
}

late RemoteConfig remoteConfig;
late List<String> infoPagesTexts;
late List<InfoScreenModel> infoScreenModels;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final Duration duration = const Duration(milliseconds: 500);

  Widget animBuilder(BuildContext c, Animation<double> anim,
      Animation<double> a2, Widget child) {
    return FadeTransition(opacity: anim, child: child);
  }

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
        title: 'WiFi Set',
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
        navigatorObservers: [
          serviceLocator<FirebaseAnalyticsService>().appAnalyticsObserver(),
        ],
        home: BlocConsumer<LoomBloc, LoomState>(
          listener: (context, state) {
            if (state is LoomStartState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => StartScreen(email: state.email),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomInfo1State) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const Info1Screen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomInfo2State) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const Info2Screen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }
            if (state is LoomInfo3State) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const Info3Screen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomConnectState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const LoomConnectScreen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomNetworksState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => NetworksScreen(
                    sec: state.sec,
                    netList: state.netList,
                  ),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomSettingsNetworkState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => SettingsNetworkScreen(
                    networkName: state.networkName,
                    loomName: state.loomName,
                  ),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomWaitState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => WaitScreen(
                    sec: state.sec,
                    messageId: state.messageId,
                  ),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomSuccessfulState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => SuccessfulScreen(
                    rate: state.rate,
                  ),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomButtonsConnectState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ButtonsConnectScreen(
                    loomName: state.loomName,
                    networkName: state.networkName,
                  ),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomFAQState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) =>
                      FAQScreen(loomEvent: state.loomEvent),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomResetState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const ResetScreen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomErrorState) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ErrorScreen(error: state.error),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }

            if (state is LoomReset106State) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const Reset106Screen(),
                  transitionsBuilder: animBuilder,
                  transitionDuration: duration,
                ),
              );
            }
          },
          builder: (context, state) {
            return const WaitScreen(sec: 0, messageId: 0);
          },
        ),
      ),
    );
  }
}
