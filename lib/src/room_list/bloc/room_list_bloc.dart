import 'package:boochat_ui/src/room_list/bloc/room_list_events.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data.dart';

class RoomListBloc extends Bloc<RoomListEvent, RoomListState> {
  final WebsocketManager _websocketManager;
  RoomListBloc(this._websocketManager) : super(const RoomListState()) {
    on<UpdateRoomListEvent>(_updateRoomList);
    _websocketManager.socketsConnected$.listen((connected) {
      if (connected) {
        _websocketManager.querySocket.onAny(_handleQuerySocketEvent);
      }
    });
  }
  _updateRoomList(UpdateRoomListEvent event, Emitter<RoomListState> emit) {
    emit(RoomListState.update(event.rooms));
  }

  _handleQuerySocketEvent(String event, dynamic data) {
    if (event == WebsocketEvents.roomList) {
      final List<Room> rooms =
          List.from(data).map((json) => Room.fromJson(json)).toList();
      add(UpdateRoomListEvent(rooms));
    } else if (event == WebsocketEvents.roomCreated) {
      final room = Room.fromJson(data);
      state.rooms.insert(0, room);
      add(UpdateRoomListEvent(state.rooms));
    } else if (event == WebsocketEvents.newRoomItem) {
      final roomItem = RoomItem.fromJson(data);
      final rooms = List.of(state.rooms);
      final room = rooms.firstWhere((room) => room.id == roomItem.roomId);
      room.hasUnreadMessage = true;
      room.items.add(roomItem);
      rooms.remove(room);
      rooms.insert(0, room);
      add(UpdateRoomListEvent(rooms));
    }
  }
}
