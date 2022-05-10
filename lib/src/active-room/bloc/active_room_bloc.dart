import 'package:boochat_ui/src/active-room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/active-room/bloc/active_room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveRoomBloc extends Bloc<ActiveRoomEvent, ActiveRoomState> {
  ActiveRoomBloc() : super(const NoActiveRoomSelectedState()) {
    on(_mapBlocEvents);
  }
  _mapBlocEvents(ActiveRoomEvent event, Emitter<ActiveRoomState> emit) {
    if (event is SelectActiveRoomEvent) {
      emit(ActiveRoomSelectedState(event.room));
    } else if (event is ClearActiveRoomEvent) {
      emit(const NoActiveRoomSelectedState());
    }
  }
}
