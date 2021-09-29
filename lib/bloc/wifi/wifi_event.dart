part of 'wifi_bloc.dart';

@immutable
abstract class WifiEvent {}

class WifiConnectEvent extends WifiEvent {}

class WifiLoginChangeEvent extends WifiEvent {
  final String data;
  WifiLoginChangeEvent({required this.data});
}

class WifiPasswordChangeEvent extends WifiEvent {
  final String data;
  WifiPasswordChangeEvent({required this.data});
}
