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
  late SharedPreferences prefs;
  String networkName = "WiFi Extender";
  String loomName = "";
  String password = "";
  String ssid = "";
  String channal = "";
  bool isScannings = false;

  LoomBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(LoomInitState()) {
    on<LoomEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();

      //FAQ SCREEN
      if (event is LoomOpenFAQEvent) {
        emit(LoomFAQState(loomEvent: event.loomEvent));
      }

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
          //TODO WAIT 2 SECONDS!
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
      if (event is LoomNetworksGetEvent && !isScannings) {
        isScannings = true;
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
        isScannings = false;
      }
      if (event is LoomNetworksChooseEvent) {
        networkName = event.networkModel.wl_ss_ssid;
        ssid = event.networkModel.wl_ss_bssid;
        channal = event.networkModel.wl_ss_channel;
        loomName = networkName + "-plus";
        prefs.setString('network_name', networkName);
        prefs.setString('bssid', ssid);
        prefs.setString('channel', channal);
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
      }

      //SETTINGS SCREEN
      if (event is LoomOpenSettingsNetworkEvent) {
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
      }
      if (event is LoomChangeLoomEvent) {
        loomName = event.data;
      }
      if (event is LoomChangePasswordEvent) {
        password = event.data;
      }
      if (event is LoomSettingsSaveEvent) {
        prefs.setString('loom_name', loomName);
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
      }
      if (event is LoomSettingsNextEvent) {
        emit(LoomWaitState());
        prefs.setString('password', password);
        ErrorAnswerModel formScanningAp = await httpApiProvider.formSetRepeater(
          ssid: ssid,
          channal: channal,
          networkName: loomName,
          password: password,
        );
        if (formScanningAp.errCode == "0") {
          emit(LoomSuccessfulState(
            networkName: networkName,
            loomName: loomName,
          ));
        } else {
          //emit(SettingsUnsuccessSaveState());
        }
      }
      if (event is LoomOpenSuccessfulEvent) {
        emit(LoomSuccessfulState(
          networkName: networkName,
          loomName: loomName,
        ));
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
      if (event is LoomClearEvent) {
        networkName = "WiFi Extender";
        loomName = "";
        password = "";
        ssid = "";
        channal = "";
        isScannings = false;
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
