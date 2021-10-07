part of 'loom_bloc.dart';

@immutable
abstract class LoomState {}

class LoomInitState extends LoomState {}

class LoomInfoState extends LoomState {
  final int index;
  final LoomEvent nextEvent;
  LoomInfoState({required this.index, required this.nextEvent});
}

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
  LoomSettingsNetworkState({required this.networkName});
}

class LoomWaitState extends LoomState {}

class LoomSuccessfulState extends LoomState {}

class LoomButtonsConnectState extends LoomState {
  final String loomName;
  final String networkName;
  LoomButtonsConnectState({required this.loomName, required this.networkName});
}

class LoomFAQState extends LoomState {}
