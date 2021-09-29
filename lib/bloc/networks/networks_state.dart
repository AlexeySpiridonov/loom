part of 'networks_bloc.dart';

@immutable
abstract class NetworksState {}

class NetworksInitState extends NetworksState {}

class NetworksListState extends NetworksState {
  final List<NetworkModel> netList;
  NetworksListState({required this.netList});
}
