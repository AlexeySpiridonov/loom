import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
  int status = 0;

  LoomBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(LoomInitState()) {
    on<LoomEvent>((event, emit) async {
      status = prefs.getInt('status') ?? 0;

      //FAQ SCREEN
      if (event is LoomOpenFAQEvent) {
        emit(LoomFAQState(loomEvent: event.loomEvent));
        FirebaseAnalytics().setCurrentScreen(screenName: 'FAQ');
      }

      //INFO SCREENS
      if (event is LoomOpenInfo1Event) {
        emit(LoomInfo1State());
        FirebaseAnalytics().setCurrentScreen(screenName: 'info 1 screen');
      }
      if (event is LoomOpenInfo2Event) {
        emit(LoomInfo2State());
        FirebaseAnalytics().setCurrentScreen(screenName: 'info 2 screen');
      }
      if (event is LoomOpenInfo3Event) {
        emit(LoomInfo3State());
        FirebaseAnalytics().setCurrentScreen(screenName: 'info 3 screen');
      }

      //LOOM CONNECT SCREEN
      if (event is LoomOpenConnectEvent) {
        add(LoomTryConnectEvent());
      }
      if (event is LoomChangeNetworkEvent) {
        networkName = event.data;
      }
      if (event is LoomTryConnectEvent) {
        emit(LoomWaitState(sec: 0, messageId: 1));
        FirebaseAnalytics().setCurrentScreen(screenName: 'Wait');
        String _result = await wifiApiProvider.connectWifi(networkName, "");
        if (_result == "successful") {
          await Future.delayed(const Duration(seconds: 2), () {});
          add(LoomNetworksGetEvent());
        } else {
          emit(LoomConnectState(error: _result));
          FirebaseAnalytics().setCurrentScreen(screenName: 'Connect');
        }
      }

      //NETWORK SCREEN
      if (event is LoomOpenNetworksEvent) {
        add(LoomNetworksGetEvent());
      }
      if (event is LoomNetworksGetEvent && !isScannings) {
        emit(LoomWaitState(sec: 0, messageId: 2));
        FirebaseAnalytics().setCurrentScreen(screenName: 'Wait');

        isScannings = true;
        String? formScanningAp = await httpApiProvider.formScanningAp();

        for (int i = 10; i > 0; i--) {
          emit(LoomWaitState(sec: i, messageId: 2));
          await Future.delayed(const Duration(seconds: 1), () {});
        }

        if (formScanningAp != null) {
          List<NetworkModel> netList = await httpApiProvider.apList();

          netList.removeWhere((item) =>
              item.wl_ss_secmo != "WPA2-PSK" &&
              item.wl_ss_secmo != "WPA-PSK/WPA2-PSK");

          emit(LoomNetworksState(sec: 0, netList: netList));
          FirebaseAnalytics().setCurrentScreen(screenName: 'Networks');
        } else {
          emit(LoomNetworksState(sec: 0, netList: const []));
          FirebaseAnalytics().setCurrentScreen(screenName: 'Networks');
        }
        isScannings = false;
      }
      if (event is LoomNetworksChooseEvent) {
        networkName = event.networkModel.wl_ss_ssid;
        ssid = event.networkModel.wl_ss_bssid;
        channal = event.networkModel.wl_ss_channel;
        loomName = networkName + "-plus";
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
        FirebaseAnalytics().setCurrentScreen(screenName: 'Settings network');
      }

      //SETTINGS SCREEN
      if (event is LoomOpenSettingsNetworkEvent) {
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
        FirebaseAnalytics().setCurrentScreen(screenName: 'Settings network');
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
        FirebaseAnalytics().setCurrentScreen(screenName: 'Settings network');
      }
      if (event is LoomSettingsNextEvent) {
        emit(LoomWaitState(sec: 30, messageId: 3));
        FirebaseAnalytics().setCurrentScreen(screenName: 'Wait');
        String formScanningAp = await httpApiProvider.formSetRepeater(
          ssid: ssid,
          channal: channal,
          networkName: loomName,
          password: password,
        );

        for (int i = 30; i > 0; i--) {
          emit(LoomWaitState(sec: i, messageId: 3));
          await Future.delayed(const Duration(seconds: 1), () {});
        }

        if (formScanningAp.isNotEmpty) {
          emit(LoomSuccessfulState(
            networkName: networkName,
            loomName: loomName,
          ));
          FirebaseAnalytics().setCurrentScreen(screenName: 'Successful');
          status = 1;
          saveValues();
        } else {
          //emit(SettingsUnsuccessSaveState());
        }
      }
      if (event is LoomOpenSuccessfulEvent) {
        FirebaseAnalytics().setCurrentScreen(screenName: 'Successful');
        emit(LoomSuccessfulState(
          networkName: networkName,
          loomName: loomName,
        ));
      }

      //BUTTONS CONNECT SCREEN
      if (event is LoomOpenButtonsEvent) {
        FirebaseAnalytics().setCurrentScreen(screenName: 'Buttons');
        emit(LoomButtonsConnectState(
          networkName: networkName,
          loomName: loomName,
        ));
      }
      if (event is LoomConnectNetworkEvent) {
        String _ = await wifiApiProvider.connectWifi(
          networkName,
          password,
        );
      }
      if (event is LoomConnectLoomEvent) {
        String _ = await wifiApiProvider.connectWifi(
          loomName,
          password,
        );
      }
      if (event is LoomClearEvent) {
        initValues();
        add(LoomOpenInfo1Event());
      }

      if (event is LoomOpenResetEvent) {
        emit(LoomResetState());
        FirebaseAnalytics().setCurrentScreen(screenName: 'Reset');
      }
    });
    loading();
  }

  void loading() async {
    prefs = await SharedPreferences.getInstance();
    loadValues();
    if (status == 1) {
      add(LoomOpenButtonsEvent());
    } else {
      add(LoomOpenInfo1Event());
    }
  }

  void saveValues() {
    prefs.setString('network_name', networkName);
    prefs.setString('loomName', loomName);
    prefs.setString('password', password);
    prefs.setString('ssid', ssid);
    prefs.setString('channel', channal);
    prefs.setInt('status', status);
  }

  void loadValues() {
    networkName = prefs.getString('network_name') ?? networkName;
    loomName = prefs.getString('loomName') ?? loomName;
    password = prefs.getString('password') ?? password;
    ssid = prefs.getString('ssid') ?? ssid;
    channal = prefs.getString('channal') ?? channal;
    status = prefs.getInt('status') ?? status;
  }

  void initValues() {
    networkName = "WiFi Extender";
    loomName = "";
    password = "";
    ssid = "";
    channal = "";
    isScannings = false;
    status = 0;
    saveValues();
  }
}
