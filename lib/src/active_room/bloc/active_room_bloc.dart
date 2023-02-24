import 'package:boochat_ui/src/active_room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data.dart';

class ActiveRoomBloc extends Bloc<ActiveRoomEvent, ActiveRoomState> {
  final WebsocketManager _websocketManager;
  ActiveRoomBloc(this._websocketManager)
      : super(const NoActiveRoomSelectedState()) {
    on(_mapBlocEvents);
    _websocketManager.querySocket
        .on(WebsocketEvents.newRoomItem, _handleNewRoomItem);
  }
  _mapBlocEvents(ActiveRoomEvent event, Emitter<ActiveRoomState> emit) {
    if (event is SelectActiveRoomEvent) {
      emit(ActiveRoomSelectedState(event.room));
    } else if (event is ClearActiveRoomEvent) {
      emit(const NoActiveRoomSelectedState());
    } else if (event is AppendRoomItemEvent &&
        state is ActiveRoomSelectedState) {
      final room = (state as ActiveRoomSelectedState).room;
      room.items.add(event.roomItem);
      emit(ActiveRoomSelectedState(room));
    } else if (event is SendMessageEvent) {
      _websocketManager.commandSocket.emit(WebsocketEvents.sendMessage, {
        'content': event.content,
        'roomId': (state as ActiveRoomSelectedState).room.id
      });
    } else if (event is FetchingActiveRoomEvent) {
      emit(const FetchingActiveRoomState());
    }
  }

  _handleNewRoomItem(dynamic data) {
    if (state is ActiveRoomSelectedState) {
      final roomItem = RoomItem.fromJson(data);
      if (roomItem.roomId == (state as ActiveRoomSelectedState).room.id) {
        if (data['sender'] != null) {
          final message = Message.fromJson(data);
          add(AppendRoomItemEvent(message));
        } else {
          final announcement = Announcement.fromJson(data);
          add(AppendRoomItemEvent(announcement));
        }
      }
    }
  }
}
