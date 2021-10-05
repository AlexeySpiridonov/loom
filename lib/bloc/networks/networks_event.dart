part of 'networks_bloc.dart';

@immutable
abstract class NetworksEvent {}

class NetworksGetEvent extends NetworksEvent {}

class NetworksChooseEvent extends NetworksEvent {
  NetworkModel networkModel;
  NetworksChooseEvent({required this.networkModel});
}
