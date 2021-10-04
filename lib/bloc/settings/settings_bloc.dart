import 'package:bloc/bloc.dart';
import 'package:loom/models/error_answer_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final HttpApiProvider httpApiProvider;

  String login = "myHomeNet-R";
  String password = "";

  SettingsBloc({required this.httpApiProvider}) : super(SettingsInitState()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SettingsLoginChangeEvent) {
        login = event.data;
      }
      if (event is SettingsPasswordChangeEvent) {
        password = event.data;
      }
      if (event is SettingsSaveEvent) {
        emit(SettingsWaitState());
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('login2', login);
        prefs.setString('password2', password);

        ErrorAnswerModel formScanningAp =
            await httpApiProvider.formSetRepeater();
        if (formScanningAp.errCode == "0") {
          emit(SettingsSuccessSaveState());
        } else {
          emit(SettingsUnsuccessSaveState());
        }
      }
    });
  }
}
