import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loom_event.dart';
part 'loom_state.dart';

class LoomBloc extends Bloc<LoomEvent, LoomState> {
  LoomBloc() : super(LoomInitState()) {
    String networkName;
    String loomName;
    String password;
    String ssid;
    String channal;
    int status;

    on<LoomEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
    });
  }
}
