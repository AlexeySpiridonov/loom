import 'package:bloc/bloc.dart';
import 'package:loom/services/wifi_api_provider.dart';
import 'package:meta/meta.dart';

part 'wifi_event.dart';
part 'wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {
  final WifiApiProvider wifiApiProvider;

  String _result = 'Nothing';
  String login = "";
  String password = "";

  WifiBloc({required this.wifiApiProvider}) : super(WifiInitial());

  @override
  Stream<WifiState> mapEventToState(WifiEvent event) async* {
    if (event is WifiLoginChangeEvent) {
      login = event.data;
    }
    if (event is WifiPasswordChangeEvent) {
      password = event.data;
    }
    if (event is WifiConnectEvent) {
      _result = await wifiApiProvider.connectWifi(login, password);
      yield WifiConnectedState(result: _result);
    }
  }
}
