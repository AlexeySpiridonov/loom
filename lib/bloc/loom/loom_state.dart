part of 'loom_bloc.dart';

@immutable
abstract class LoomState {}

class LoomInitState extends LoomState {}

class LoomFAQState extends LoomState {
  final LoomEvent loomEvent;
  LoomFAQState({required this.loomEvent});
}

class LoomStartState extends LoomState {}

class LoomInfo1State extends LoomState {}

class LoomInfo2State extends LoomState {}

class LoomInfo3State extends LoomState {}

class LoomConnectState extends LoomState {}

class LoomNetworksState extends LoomState {
  final int sec;
  final List<NetworkModel> netList;
  LoomNetworksState({required this.sec, required this.netList});
}

class LoomSettingsNetworkState extends LoomState {
  final String networkName;
  final String loomName;
  LoomSettingsNetworkState({required this.networkName, required this.loomName});
}

class LoomWaitState extends LoomState {
  final int sec;
  final int messageId;
  LoomWaitState({required this.sec, required this.messageId});
}

class LoomSuccessfulState extends LoomState {
  final int rate;
  LoomSuccessfulState({required this.rate});
}

class LoomButtonsConnectState extends LoomState {
  final String loomName;
  final String networkName;
  LoomButtonsConnectState({required this.loomName, required this.networkName});
}

class LoomResetState extends LoomState {}

class LoomErrorState extends LoomState {
  final int error;
  LoomErrorState({required this.error});
}

class LoomReset106State extends LoomState {}
