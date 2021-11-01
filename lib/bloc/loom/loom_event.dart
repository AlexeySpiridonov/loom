part of 'loom_bloc.dart';

@immutable
abstract class LoomEvent {}

class LoomOpenFAQEvent extends LoomEvent {
  final LoomEvent loomEvent;
  LoomOpenFAQEvent({required this.loomEvent});
}

class LoomOpenInfo1Event extends LoomEvent {}

class LoomOpenInfo2Event extends LoomEvent {}

class LoomOpenInfo3Event extends LoomEvent {}

class LoomOpenConnectEvent extends LoomEvent {}

class LoomChangeNetworkEvent extends LoomEvent {
  final String data;
  LoomChangeNetworkEvent({required this.data});
}

class LoomOpenNetworksEvent extends LoomEvent {}

class LoomNetworksChooseEvent extends LoomEvent {
  final NetworkModel networkModel;
  LoomNetworksChooseEvent({required this.networkModel});
}

class LoomOpenSettingsNetworkEvent extends LoomEvent {}

class LoomChangeLoomEvent extends LoomEvent {
  final String data;
  LoomChangeLoomEvent({required this.data});
}

class LoomChangePasswordEvent extends LoomEvent {
  final String data;
  LoomChangePasswordEvent({required this.data});
}

class LoomSettingsSaveEvent extends LoomEvent {}

class LoomSettingsNextEvent extends LoomEvent {}

class LoomOpenSuccessfulEvent extends LoomEvent {}

class LoomOpenButtonsEvent extends LoomEvent {}

class LoomClearEvent extends LoomEvent {}

class LoomConnectNetworkEvent extends LoomEvent {}

class LoomConnectLoomEvent extends LoomEvent {}

class LoomOpenResetEvent extends LoomEvent {}
