part of 'loom_bloc.dart';

@immutable
abstract class LoomState {}

class LoomInitState extends LoomState {}

class LoomFAQState extends LoomState {
  final LoomEvent loomEvent;
  LoomFAQState({required this.loomEvent});
}

class LoomInfo1State extends LoomState {}

class LoomInfo2State extends LoomState {}

class LoomInfo3State extends LoomState {}

class LoomConnectState extends LoomState {
  final String error;
  LoomConnectState({required this.error});
}

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
  final String networkName;
  final String loomName;
  LoomSuccessfulState({required this.networkName, required this.loomName});
}

class LoomButtonsConnectState extends LoomState {
  final String loomName;
  final String networkName;
  LoomButtonsConnectState({required this.loomName, required this.networkName});
}

class LoomResetState extends LoomState {}
