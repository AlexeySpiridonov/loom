part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitState extends SettingsState {}

class SettingsEditState extends SettingsState {
  final String networkName;
  SettingsEditState({required this.networkName});
}

class SettingsWaitState extends SettingsState {}

class SettingsSuccessSaveState extends SettingsState {}

class SettingsUnsuccessSaveState extends SettingsState {}
