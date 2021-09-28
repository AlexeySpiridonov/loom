part of 'nav_bloc.dart';

@immutable
abstract class NavEvent {}

class NavChangePageEvent extends NavEvent {
  final int screenNumber;
  NavChangePageEvent({required this.screenNumber});
}

class NavNextPageEvent extends NavEvent {}
