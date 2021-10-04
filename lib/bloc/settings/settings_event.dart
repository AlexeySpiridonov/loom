part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsSaveEvent extends SettingsEvent {}

class SettingsLoginChangeEvent extends SettingsEvent {
  final String data;
  SettingsLoginChangeEvent({required this.data});
}

class SettingsPasswordChangeEvent extends SettingsEvent {
  final String data;
  SettingsPasswordChangeEvent({required this.data});
}
