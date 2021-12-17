import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:loom/main.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:loom/services/logger.dart';
import 'package:loom/services/wifi_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loom_event.dart';
part 'loom_state.dart';

class LoomBloc extends Bloc<LoomEvent, LoomState> {
  final WifiApiProvider wifiApiProvider;
  final HttpApiProvider httpApiProvider;
  late SharedPreferences prefs;
  String networkName = "WiFi Extender";
  String networkPostfix = "-plus";
  String loomName = "";
  String password = "";
  String ssid = "";
  String channel = "";
  bool isScannings = false;
  int status = 0;
  String logs = "";
  String email = "";
  int rate = 0;

  var logger = Logger(
    printer: MyPrinter(),
    output: LoomConsoleOutput(),
  );
  final info = NetworkInfo();
  var fb = FirebaseAnalytics();

  LoomBloc({
    required this.httpApiProvider,
    required this.wifiApiProvider,
  }) : super(LoomInitState()) {
    on<LoomEvent>((event, emit) async {
      switch (event.runtimeType) {
        case LoomOpenFAQEvent: // Открыть скрин с FAQ
          await openFAQScreen(emit, event);
          break;
        case LoomOpenStartEvent: //Открыть стартовый скрин
          await openStartScreen(emit, event);
          break;
        case LoomChangeEmailEvent: //Смена email
          await changeEmail(emit, event);
          break;
        case LoomSendEmailEvent: //Смена email
          await sendEmail(emit, event);
          break;
        case LoomOpenInfo1Event: //Открыть скрин info 1
          await openInfo1Screen(emit, event);
          break;
        case LoomOpenInfo2Event: //Открыть скрин info 2
          await openInfo2Screen(emit, event);
          break;
        case LoomOpenInfo3Event: //Открыть скрин info 3
          await openInfo3Screen(emit, event);
          break;
        case LoomOpenConnectEvent: //Открыть скрин с подкючением к loom
          await openConnectScreen(emit, event);
          break;
        case LoomChangeNetworkEvent: //Смена имени лум на странице подключения к loom
          await changeNetworkName(event);
          break;
        case LoomOpenNetworksEvent: //Открыть скрин со списком сетей
          await openNetworksScreen(emit, event);
          break;
        case LoomNetworksChooseEvent: //Выбрать сеть в списке сетей
          await networksChoose(emit, event);
          break;
        case LoomOpenSettingsNetworkEvent: //Открыть скрин с настройкой сети
          await openSettingsNetworkScreen(emit, event);
          break;
        case LoomChangeLoomEvent: //Смена имени лум
          await changeLoomName(event);
          break;
        case LoomChangePasswordEvent: //Смена пароля
          await changePassword(event);
          break;
        case LoomSettingsSaveEvent: //Сохранить имя сети лум
          await saveSettings(emit, event);
          break;
        case LoomSettingsNextEvent: //Отправить на репитер настройки
          await settingsNext(emit, event);
          break;
        case LoomOpenSuccessfulEvent: //Открыть скрин успеха
          await openSuccessfulScreen(emit, event);
          break;
        case LoomSetRatingEvent: //Нажатие на звездочки
          await setRating(emit, event);
          break;
        case LoomSendRatingEvent: //Отправка рейтинг
          await sendRating(emit, event);
          break;
        case LoomOpenButtonsEvent: //Открыть скрин с кнопками
          await openButtonsScreen(emit, event);
          break;
        case LoomConnectNetworkEvent: //Подключиться к сети wifi (Со страницы с кнопками)
          await connectToNetwork(emit, event);
          break;
        case LoomConnectLoomEvent: //Подключиться к лум (Со страницы с кнопками)
          await connectToLoom(emit, event);
          break;
        case LoomClearEvent: //Начать всё сначала
          await clearAll(emit, event);
          break;
        case LoomOpenResetEvent: //Открыть скрин с ресетом
          await openReset(emit, event);
          break;
        default:
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
      if (remoteConfig.getBool('enter_email')) {
        add(LoomOpenStartEvent());
      } else {
        add(LoomOpenInfo1Event());
      }
      // add(LoomOpenSuccessfulEvent());
    }
  }

  Future<void> createError() async {
    throw Exception('FooException');
  }

  void saveValues() {
    prefs.setString('network_name', networkName);
    prefs.setString('loomName', loomName);
    prefs.setString('password', password);
    prefs.setString('ssid', ssid);
    prefs.setInt('status', status);
    prefs.setString('email', email);
  }

  void loadValues() {
    networkName = prefs.getString('network_name') ?? networkName;
    loomName = prefs.getString('loomName') ?? loomName;
    password = prefs.getString('password') ?? password;
    ssid = prefs.getString('ssid') ?? ssid;
    status = prefs.getInt('status') ?? status;
    email = prefs.getString('email') ?? email;
  }

  void initValues() {
    networkName = "WiFi Extender";
    loomName = "";
    password = "";
    ssid = "";
    channel = "";
    email = "";
    isScannings = false;
    status = 0;
    saveValues();
  }

  Future<void> openScreen({
    required String screenName,
    required emit,
    required state,
  }) async {
    emit(state);
    logger.i("Open screen $screenName");
    fb.setCurrentScreen(screenName: screenName);
    fb.logEvent(name: screenName, parameters: null);
  }

  //screens
  Future<void> openFAQScreen(emit, event) async {
    openScreen(
      screenName: 'FAQ',
      emit: emit,
      state: LoomFAQState(loomEvent: event.loomEvent),
    );
  }

  Future<void> openStartScreen(emit, event) async {
    openScreen(
      screenName: 'start',
      emit: emit,
      state: LoomStartState(email: email),
    );
  }

  Future<void> changeEmail(emit, event) async {
    email = event.email;
  }

  Future<void> sendEmail(emit, event) async {
    if (EmailValidator.validate(email)) {
      httpApiProvider.sendEmail(email);
      saveValues();
      openInfo1Screen(emit, event);
    }
  }

  Future<void> openInfo1Screen(emit, event) async {
    openScreen(
      screenName: 'info_1',
      emit: emit,
      state: LoomInfo1State(),
    );
  }

  Future<void> openInfo2Screen(emit, event) async {
    openScreen(
      screenName: 'info_2',
      emit: emit,
      state: LoomInfo2State(),
    );
  }

  Future<void> openInfo3Screen(emit, event) async {
    openScreen(
      screenName: 'info_3',
      emit: emit,
      state: LoomInfo3State(),
    );
  }

  Future<void> openConnectScreen(emit, event) async {
    openScreen(
      screenName: 'Wait',
      emit: emit,
      state: LoomWaitState(sec: 0, messageId: 1),
    );
    String _result = await wifiApiProvider.connectWifi(networkName, "");

    await Future.delayed(const Duration(seconds: 5), () {});

    if (_result != "successful" && _result != "already associated.") {
      if (status == 1) {
        openScreen(
          screenName: 'Reset',
          emit: emit,
          state: LoomResetState(),
        );
      } else {
        openScreen(
          screenName: 'Connect',
          emit: emit,
          state: LoomConnectState(),
        );
      }
    } else {
      await Future.delayed(const Duration(seconds: 2), () {});
      await openNetworksScreen(emit, event);
    }
    status = 1;
  }

  Future<void> changeNetworkName(event) async {
    networkName = event.data;
  }

  Future<void> openNetworksScreen(emit, event) async {
    if (isScannings) {
      logger.i("already scanning...");
      return;
    }
    isScannings = true;
    String? formScanningAp = await httpApiProvider.formScanningAp();

    if (formScanningAp != null) {
      openScreen(
        screenName: 'Wait',
        emit: emit,
        state: LoomWaitState(sec: 0, messageId: 2),
      );

      for (int i = 10; i > 0; i--) {
        emit(LoomWaitState(sec: i, messageId: 2));
        await Future.delayed(const Duration(seconds: 1), () {});
      }

      List<NetworkModel>? netList = await httpApiProvider.apList();

      if (netList == null) {
        openScreen(
          screenName: 'Error_105',
          emit: emit,
          state: LoomErrorState(error: 105),
        );
        return;
      }

      netList.removeWhere((item) =>
          item.wl_ss_secmo != "WPA2-PSK" &&
          item.wl_ss_secmo != "WPA-PSK/WPA2-PSK");

      openScreen(
        screenName: 'Networks',
        emit: emit,
        state: LoomNetworksState(sec: 0, netList: netList),
      );
    } else {
      logger.w(await info.getWifiName());
      openScreen(
        screenName: 'Error_102',
        emit: emit,
        state: LoomErrorState(error: 102),
      );
    }
    isScannings = false;
  }

  Future<void> networksChoose(emit, event) async {
    networkName = event.networkModel.wl_ss_ssid;
    ssid = event.networkModel.wl_ss_bssid;
    channel = event.networkModel.wl_ss_channel;
    loomName = networkName + networkPostfix;

    openSettingsNetworkScreen(emit, event);
  }

  Future<void> openSettingsNetworkScreen(emit, event) async {
    openScreen(
      screenName: 'Settings_network',
      emit: emit,
      state: LoomSettingsNetworkState(
        networkName: networkName,
        loomName: loomName,
      ),
    );
  }

  Future<void> changeLoomName(event) async {
    loomName = event.data;
  }

  Future<void> changePassword(event) async {
    password = event.data;
  }

  Future<void> saveSettings(emit, event) async {
    prefs.setString('loom_name', loomName);
    openScreen(
      screenName: 'Settings_network',
      emit: emit,
      state: LoomSettingsNetworkState(
        networkName: networkName,
        loomName: loomName,
      ),
    );
  }

  Future<void> settingsNext(emit, event) async {
    //показываем экран ожидания
    openScreen(
      screenName: 'Wait',
      emit: emit,
      state: LoomWaitState(sec: 30, messageId: 3),
    );

    //записываем настройки в лум
    String? formSetRepeater = await httpApiProvider.formSetRepeater(
      ssid: ssid,
      channel: channel,
      networkName: loomName,
      password: password,
    );
    if (formSetRepeater == null) {
      openScreen(
        screenName: 'Error_103',
        emit: emit,
        state: LoomErrorState(error: 103),
      );
      return;
    }

    // ждем 30 сек
    for (int i = 30; i >= 0; i--) {
      emit(LoomWaitState(sec: i, messageId: 3));
      await Future.delayed(const Duration(seconds: 1), () {});
    }

    //чекаем основную сеть
    var _result = await wifiApiProvider.connectWifi(
      networkName,
      password,
    );
    if (_result != "successful" && _result != "already associated.") {
      openScreen(
        screenName: 'Reset_106',
        emit: emit,
        state: LoomReset106State(),
      );
      return;
    }

    //чекаем лум
    var _result2 = await wifiApiProvider.connectWifi(
      loomName,
      password,
    );
    if (_result2 != "successful" && _result2 != "already associated.") {
      openScreen(
        screenName: 'Reset_106',
        emit: emit,
        state: LoomReset106State(),
      );
      return;
    }

    //все подключения прошли, запоминаем стейт
    status = 2;
    saveValues();

    //проверяем инет на всякий случай
    /*
    String? resp = await httpApiProvider.getGoogle();
    if (resp == null) {
      openScreen(
        screenName: 'Error_104',
        emit: emit,
        state: LoomErrorState(error: 104),
      );
      return;
    }
    */

    //все успешно
    openScreen(
      screenName: 'Successful',
      emit: emit,
      state: LoomSuccessfulState(
        rate: rate,
      ),
    );
  }

  Future<void> openSuccessfulScreen(emit, event) async {
    openScreen(
      screenName: 'Successful',
      emit: emit,
      state: LoomSuccessfulState(
        rate: rate,
      ),
    );
  }

  Future<void> setRating(emit, event) async {
    rate = event.rating.toInt();
    openScreen(
      screenName: 'Successful',
      emit: emit,
      state: LoomSuccessfulState(
        rate: rate,
      ),
    );
  }

  Future<void> sendRating(emit, event) async {
    httpApiProvider.sendEmailAndStars(email, rate);
    openButtonsScreen(emit, event);
  }

  Future<void> openButtonsScreen(emit, event) async {
    openScreen(
      screenName: 'Buttons',
      emit: emit,
      state: LoomButtonsConnectState(
        networkName: networkName,
        loomName: loomName,
      ),
    );
  }

  Future<void> connectToNetwork(emit, event) async {
    String _ = await wifiApiProvider.connectWifi(
      networkName,
      password,
    );
  }

  Future<void> connectToLoom(emit, event) async {
    String _ = await wifiApiProvider.connectWifi(
      loomName,
      password,
    );
  }

  Future<void> clearAll(emit, event) async {
    initValues();
    add(LoomOpenInfo1Event());
  }

  Future<void> openReset(emit, event) async {
    logger.e("loading reset screen...");
    openScreen(
      screenName: 'Reset',
      emit: emit,
      state: LoomResetState(),
    );
  }

  void writeLogs() {}
}
