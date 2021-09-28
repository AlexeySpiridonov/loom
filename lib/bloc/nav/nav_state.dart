part of 'nav_bloc.dart';

@immutable
abstract class NavState {}

class NavScreenState extends NavState {
  final int screenNumber;
  NavScreenState({required this.screenNumber});
}
