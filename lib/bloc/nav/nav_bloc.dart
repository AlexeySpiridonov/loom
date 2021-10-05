import 'package:bloc/bloc.dart';
import 'package:loom/main.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int screenNumber = 4;
  List<int> history = [];

  NavBloc() : super(NavScreenState(screenNumber: 4)) {
    on<NavEvent>((event, emit) {
      if (event is NavChangePageEvent) {
        history.add(screenNumber);
        screenNumber = event.screenNumber;
        emit(NavScreenState(screenNumber: screenNumber));
      }
      if (event is NavNextPageEvent) {
        if (screenNumber < screens.length - 1) {
          history.add(screenNumber);
          screenNumber++;
          emit(NavScreenState(screenNumber: screenNumber));
        }
      }
      if (event is NavPreviousPageEvent) {
        if (history.isNotEmpty) {
          screenNumber = history.last;
          history.removeLast();
          emit(NavScreenState(screenNumber: screenNumber));
        }
      }
      if (event is NavClearEvent) {
        history = [];
        screenNumber = 0;
        emit(NavScreenState(screenNumber: screenNumber));
      }
    });
  }
}
