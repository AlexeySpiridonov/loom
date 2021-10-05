part of 'loom_connect_bloc.dart';

@immutable
abstract class LoomConnectEvent {}

class LoomConnectTryEvent extends LoomConnectEvent {}

class LoomConnectLoginChangeEvent extends LoomConnectEvent {
  final String data;
  LoomConnectLoginChangeEvent({required this.data});
}
