part of 'loom_connect_bloc.dart';

@immutable
abstract class LoomConnectState {}

class LoomConnectInitState extends LoomConnectState {}

class LoomConnectEnterNameState extends LoomConnectState {}

class LoomConnectSuccessfulState extends LoomConnectState {}
