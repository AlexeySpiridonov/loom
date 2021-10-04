import 'package:bloc/bloc.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:loom/services/wifi_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'buttons_connect_event.dart';
part 'buttons_connect_state.dart';

class ButtonsConnectBloc
    extends Bloc<ButtonsConnectEvent, ButtonsConnectState> {
  final WifiApiProvider wifiApiProvider;
  final HttpApiProvider httpApiProvider;

  ButtonsConnectBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(ButtonsConnectInitial()) {
    on<ButtonsConnectEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (event is ButtonsHomeConnectEvent) {
        String login = prefs.getString('login') ?? "";
        String password = prefs.getString('password') ?? "";
        String _result = await wifiApiProvider.connectWifi(login, password);
      }
      if (event is ButtonsLoomConnectEvent) {
        String login = prefs.getString('login2') ?? "";
        String password = prefs.getString('password2') ?? "";
        String _result = await wifiApiProvider.connectWifi(login, password);
      }
    });
  }
}
