import 'package:bloc/bloc.dart';
import 'package:loom/services/wifi_api_provider.dart';
import 'package:meta/meta.dart';

part 'loom_connect_event.dart';
part 'loom_connect_state.dart';

class LoomConnectBloc extends Bloc<LoomConnectEvent, LoomConnectState> {
  final WifiApiProvider wifiApiProvider;
  String loomNetworkName = "WiFi Extender";

  LoomConnectBloc({
    required this.wifiApiProvider,
  }) : super(LoomConnectInitState()) {
    on<LoomConnectEvent>((event, emit) async {
      if (event is LoomConnectLoginChangeEvent) {
        loomNetworkName = event.data;
      }
      if (event is LoomConnectTryEvent) {
        String _result = await wifiApiProvider.connectWifi(loomNetworkName, "");
        emit(LoomConnectSuccessfulState());
      }
    });
  }
}
