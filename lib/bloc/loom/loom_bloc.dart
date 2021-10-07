import 'package:bloc/bloc.dart';
import 'package:loom/models/error_answer_model.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:loom/services/wifi_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loom_event.dart';
part 'loom_state.dart';

class LoomBloc extends Bloc<LoomEvent, LoomState> {
  final WifiApiProvider wifiApiProvider;
  final HttpApiProvider httpApiProvider;
  String networkName = "WiFi Extender";
  String loomName = "";
  String password = "";
  String ssid = "";
  String channal = "";
  int status = 0;
  late SharedPreferences prefs;

  LoomBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(LoomInitState()) {
    on<LoomEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();

      //INFO SCREEN
      if (event is LoomOpenInfoEvent) {
        emit(LoomInfoState(index: event.index, nextEvent: event.nextEvent));
      }

      //LOOM CONNECT SCREEN
      if (event is LoomOpenConnectEvent) {
        emit(LoomConnectState(error: ""));
        add(LoomTryConnectEvent());
      }
      if (event is LoomChangeNetworkEvent) {
        networkName = event.data;
      }
      if (event is LoomTryConnectEvent) {
        String _result = await wifiApiProvider.connectWifi(networkName, "");
        if (_result == "successful") {
          emit(LoomNetworksState(sec: 0, netList: const []));
          add(LoomNetworksGetEvent());
        } else {
          emit(LoomConnectState(error: _result));
        }
      }

      //NETWORK SCREEN
      if (event is LoomOpenNetworksEvent) {
        emit(LoomNetworksState(sec: 0, netList: const []));
        add(LoomNetworksGetEvent());
      }
      if (event is LoomNetworksGetEvent) {
        String? formScanningAp = await httpApiProvider.formScanningAp();

        for (int i = 10; i > 0; i--) {
          emit(LoomNetworksState(sec: i, netList: const []));
          await Future.delayed(const Duration(seconds: 1), () {});
        }

        if (formScanningAp != null) {
          List<NetworkModel> netList = await httpApiProvider.apList();

          netList.removeWhere((item) =>
              item.wl_ss_secmo != "WPA2-PSK" &&
              item.wl_ss_secmo != "WPA-PSK/WPA2-PSK");

          emit(LoomNetworksState(sec: 0, netList: netList));
        } else {
          emit(LoomNetworksState(sec: 0, netList: const []));
        }
      }
      if (event is LoomNetworksChooseEvent) {
        networkName = event.networkModel.wl_ss_ssid;
        ssid = event.networkModel.wl_ss_bssid;
        channal = event.networkModel.wl_ss_channel;
        loomName = networkName + "-plus";
        // prefs.setString('bssid', event.networkModel.wl_ss_bssid);
        // prefs.setString('channel', event.networkModel.wl_ss_channel);
        // prefs.setString('network_name', event.networkModel.wl_ss_ssid);
        emit(LoomSettingsNetworkState(networkName: networkName));
      }

      //SETTINGS SCREEN
      if (event is LoomChangeLoomEvent) {
        loomName = event.data;
      }
      if (event is LoomChangePasswordEvent) {
        password = event.data;
      }
      if (event is LoomSettingsSaveEvent) {
        emit(LoomWaitState());
        prefs.setString('loom_name', loomName);
        prefs.setString('password', password);

        ErrorAnswerModel formScanningAp = await httpApiProvider.formSetRepeater(
          ssid: ssid,
          channal: channal,
          networkName: loomName,
          password: password,
        );
        if (formScanningAp.errCode == "0") {
          emit(LoomSuccessfulState());
        } else {
          //emit(SettingsUnsuccessSaveState());
        }
      }

      //BUTTONS CONNECT SCREEN
      if (event is LoomOpenButtonsEvent) {
        emit(LoomButtonsConnectState(
          networkName: networkName,
          loomName: loomName,
        ));
      }
      if (event is LoomConnectNetworkEvent) {
        String _result = await wifiApiProvider.connectWifi(
          networkName,
          password,
        );
      }
      if (event is LoomConnectLoomEvent) {
        String _result = await wifiApiProvider.connectWifi(
          loomName,
          password,
        );
      }
    });

    add(
      LoomOpenInfoEvent(
        index: 0,
        nextEvent: LoomOpenInfoEvent(
          index: 1,
          nextEvent: LoomOpenInfoEvent(
            index: 2,
            nextEvent: LoomOpenConnectEvent(),
          ),
        ),
      ),
    );
  }

  changeStatus(newStatus) {}
}
