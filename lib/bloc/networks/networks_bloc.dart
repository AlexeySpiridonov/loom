import 'package:bloc/bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'networks_event.dart';
part 'networks_state.dart';

class NetworksBloc extends Bloc<NetworksEvent, NetworksState> {
  final HttpApiProvider httpApiProvider;

  NetworksBloc({required this.httpApiProvider}) : super(NetworksInitState()) {
    on<NetworksEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (event is NetworksGetEvent) {
        String? formScanningAp = await httpApiProvider.formScanningAp();

        print(formScanningAp);

        for (int i = 10; i > 0; i--) {
          emit(NetworksWaitState(sec: i));
          await Future.delayed(const Duration(seconds: 1), () {});
        }

        if (formScanningAp != null) {
          List<NetworkModel> netList = await httpApiProvider.apList();

          netList.removeWhere((item) =>
              item.wl_ss_secmo != "WPA2-PSK" &&
              item.wl_ss_secmo != "WPA-PSK/WPA2-PSK");

          emit(NetworksListState(netList: netList));
        } else {
          print("null is formScanningAp");
        }
      }
      if (event is NetworksChooseEvent) {
        prefs.setString('bssid', event.networkModel.wl_ss_bssid);
        prefs.setString('channel', event.networkModel.wl_ss_channel);
        prefs.setString('network_name', event.networkModel.wl_ss_ssid);
      }
    });
  }
}
