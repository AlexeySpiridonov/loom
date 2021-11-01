import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  String channel = "";
  bool isScannings = false;
  int status = 0;
  var logger = Logger();

  LoomBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(LoomInitState()) {
    on<LoomEvent>((event, emit) async {
      //FAQ SCREEN
      if (event is LoomOpenFAQEvent) {
        emit(LoomFAQState(loomEvent: event.loomEvent));
        openScreen(screenName: 'FAQ');
      }

      //INFO SCREENS
      if (event is LoomOpenInfo1Event) {
        emit(LoomInfo1State());
        openScreen(screenName: 'info 1 screen');
      }
      if (event is LoomOpenInfo2Event) {
        emit(LoomInfo2State());
        openScreen(screenName: 'info 2 screen');
      }
      if (event is LoomOpenInfo3Event) {
        emit(LoomInfo3State());
        openScreen(screenName: 'info 3 screen');
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
        openScreen(screenName: 'Wait');
        String _result = await wifiApiProvider.connectWifi(networkName, "");

        await Future.delayed(const Duration(seconds: 5), () {});

        if (_result != "successful" && _result != "already associated.") {
          if (status == 1) {
            emit(LoomResetState());
          } else {
            emit(LoomConnectState());
            openScreen(screenName: 'Connect');
          }
        } else {
          await Future.delayed(const Duration(seconds: 2), () {});
          add(LoomNetworksGetEvent());
        }
        status = 1;
      }

      //NETWORK SCREEN
      if (event is LoomOpenNetworksEvent) {
        add(LoomNetworksGetEvent());
      }
      if (event is LoomNetworksGetEvent && !isScannings) {
        isScannings = true;
        String? formScanningAp = await httpApiProvider.formScanningAp();

        if (formScanningAp != null) {
          emit(LoomWaitState(sec: 0, messageId: 2));
          openScreen(screenName: 'Wait');

          for (int i = 10; i > 0; i--) {
            emit(LoomWaitState(sec: i, messageId: 2));
            await Future.delayed(const Duration(seconds: 1), () {});
          }

          List<NetworkModel>? netList = await httpApiProvider.apList();

          if (netList == null) {
            emit(LoomErrorState(error: 105));
            openScreen(screenName: 'Error 105');
            return;
          }

          netList.removeWhere((item) =>
              item.wl_ss_secmo != "WPA2-PSK" &&
              item.wl_ss_secmo != "WPA-PSK/WPA2-PSK");

          emit(LoomNetworksState(sec: 0, netList: netList));
          openScreen(screenName: 'Networks');
        } else {
          emit(LoomErrorState(error: 102));
          openScreen(screenName: 'Error 102');
        }
        isScannings = false;
      }
      if (event is LoomNetworksChooseEvent) {
        networkName = event.networkModel.wl_ss_ssid;
        ssid = event.networkModel.wl_ss_bssid;
        channel = event.networkModel.wl_ss_channel;
        loomName = networkName + "-plus";
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
        openScreen(screenName: 'Settings network');
      }

      //SETTINGS SCREEN
      if (event is LoomOpenSettingsNetworkEvent) {
        emit(LoomSettingsNetworkState(
          networkName: networkName,
          loomName: loomName,
        ));
        openScreen(screenName: 'Settings network');
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
        openScreen(screenName: 'Settings network');
      }
      if (event is LoomSettingsNextEvent) {
        emit(LoomWaitState(sec: 30, messageId: 3));
        openScreen(screenName: 'Wait');
        String? formSetRepeater = await httpApiProvider.formSetRepeater(
          ssid: ssid,
          channel: channel,
          networkName: loomName,
          password: password,
        );

        if (formSetRepeater != null) {
          for (int i = 30; i > 0; i--) {
            emit(LoomWaitState(sec: i, messageId: 3));
            await Future.delayed(const Duration(seconds: 1), () {});
            if (i == 10) {
              await wifiApiProvider.connectWifi(
                networkName,
                password,
              );
            } else if (i == 5) {
              String? resp = await httpApiProvider.getGoogle();
              if (resp == null) {
                emit(LoomErrorState(error: 104));
                openScreen(screenName: 'Error 104');
                return;
              }

              await wifiApiProvider.connectWifi(
                loomName,
                password,
              );
            }
          }

          emit(LoomSuccessfulState(
            networkName: networkName,
            loomName: loomName,
          ));
          openScreen(screenName: 'Successful');
          status = 2;
          saveValues();
        } else {
          emit(LoomErrorState(error: 103));
          openScreen(screenName: 'Error 103');
        }
      }
      if (event is LoomOpenSuccessfulEvent) {
        openScreen(screenName: 'Successful');
        emit(LoomSuccessfulState(
          networkName: networkName,
          loomName: loomName,
        ));
      }

      //BUTTONS CONNECT SCREEN
      if (event is LoomOpenButtonsEvent) {
        openScreen(screenName: 'Buttons');
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
        openScreen(screenName: 'Reset');
      }
    });
    loading();
  }

  void loading() async {
    prefs = await SharedPreferences.getInstance();
    loadValues();
    if (status == 2) {
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
    prefs.setInt('status', status);
  }

  void loadValues() {
    networkName = prefs.getString('network_name') ?? networkName;
    loomName = prefs.getString('loomName') ?? loomName;
    password = prefs.getString('password') ?? password;
    ssid = prefs.getString('ssid') ?? ssid;
    status = prefs.getInt('status') ?? status;
  }

  void initValues() {
    networkName = "WiFi Extender";
    loomName = "";
    password = "";
    ssid = "";
    channel = "";
    isScannings = false;
    status = 0;
    saveValues();
  }

  void openScreen({required String screenName}) {
    logger.i("Open screen $screenName");
    FirebaseAnalytics().setCurrentScreen(screenName: screenName);
  }
}
