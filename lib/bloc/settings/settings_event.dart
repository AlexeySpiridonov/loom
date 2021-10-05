part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsSaveEvent extends SettingsEvent {}

class SettingsGetNetworkNameEvent extends SettingsEvent {}

class SettingsLoomNameChangeEvent extends SettingsEvent {
  final String data;
  SettingsLoomNameChangeEvent({required this.data});
}

class SettingsPasswordChangeEvent extends SettingsEvent {
  final String data;
  SettingsPasswordChangeEvent({required this.data});
}
