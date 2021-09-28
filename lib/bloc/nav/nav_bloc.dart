import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:loom/screens_data.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int screenNumber = 0;

  NavBloc() : super(NavScreenState(screenNumber: 0)) {
    on<NavEvent>((event, emit) {
      if (event is NavChangePageEvent) {
        screenNumber = event.screenNumber;
        emit(NavScreenState(screenNumber: screenNumber));
      }
      if (event is NavNextPageEvent) {
        screenNumber++;
        if (screenNumber >= screens.length) screenNumber = screens.length - 1;
        emit(NavScreenState(screenNumber: screenNumber));
      }
    });
  }
}
