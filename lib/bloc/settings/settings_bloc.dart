import 'package:bloc/bloc.dart';
import 'package:loom/models/error_answer_model.dart';
import 'package:loom/services/http_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final HttpApiProvider httpApiProvider;

  String loomName = "";
  String password = "";

  SettingsBloc({required this.httpApiProvider}) : super(SettingsInitState()) {
    on<SettingsEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      if (event is SettingsGetNetworkNameEvent) {
        String networkName = prefs.getString("network_name") ?? "myHomeNetwork";
        loomName = networkName + "-plus";
        emit(SettingsEditState(networkName: networkName));
      }
      if (event is SettingsLoomNameChangeEvent) {
        loomName = event.data;
      }
      if (event is SettingsPasswordChangeEvent) {
        password = event.data;
      }
      if (event is SettingsSaveEvent) {
        emit(SettingsWaitState());
        prefs.setString('loom_name', loomName);
        prefs.setString('password', password);
        String bssid = prefs.getString('bssid') ?? "";
        String channal = prefs.getString('channal') ?? "";

        ErrorAnswerModel formScanningAp = await httpApiProvider.formSetRepeater(
          ssid: bssid,
          channal: channal,
          networkName: loomName,
          password: password,
        );
        if (formScanningAp.errCode == "0") {
          emit(SettingsSuccessSaveState());
        } else {
          emit(SettingsUnsuccessSaveState());
        }
      }
    });
  }
}
