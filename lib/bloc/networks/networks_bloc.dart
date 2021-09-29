import 'package:bloc/bloc.dart';
import 'package:loom/models/network_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:meta/meta.dart';

part 'networks_event.dart';
part 'networks_state.dart';

class NetworksBloc extends Bloc<NetworksEvent, NetworksState> {
  final HttpApiProvider httpApiProvider;

  NetworksBloc({required this.httpApiProvider}) : super(NetworksInitState()) {
    on<NetworksEvent>((event, emit) async {
      if (event is NetworksGetEvent) {
        List<NetworkModel> netList = await httpApiProvider.apList();
        emit(NetworksListState(netList: netList));
      }
    });
    add(NetworksGetEvent());
  }
}
