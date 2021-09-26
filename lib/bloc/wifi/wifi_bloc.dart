import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

part 'wifi_event.dart';
part 'wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _result = 'Nothing';
  String login = "";
  String password = "";

  WifiBloc() : super(WifiInitial());

  Future<String> _getBatteryLevel() async {
    try {
      final String result = await platform.invokeMethod(
          'getBatteryLevel', {"login": login, "password": password});
      return 'Connect with result: $result.';
    } on PlatformException catch (e) {
      return "Failed to connect. Error: $e";
    }
  }

  @override
  Stream<WifiState> mapEventToState(WifiEvent event) async* {
    if (event is WifiLoginChangeEvent) {
      login = event.data;
    }
    if (event is WifiPasswordChangeEvent) {
      password = event.data;
    }
    if (event is WifiConnectEvent) {
      _result = await _getBatteryLevel();
      yield WifiConnectedState(result: _result);
    }
  }
}
