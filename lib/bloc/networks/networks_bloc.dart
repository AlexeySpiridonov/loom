import 'package:bloc/bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:meta/meta.dart';

part 'networks_event.dart';
part 'networks_state.dart';

class NetworksBloc extends Bloc<NetworksEvent, NetworksState> {
  NetworksBloc() : super(NetworksInitState()) {
    on<NetworksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
