import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart';

import '../data.dart';

class QuerySocketManager {
  List<Room> _roomList = List.empty();

  final roomList$ = StreamController<List<Room>>.broadcast();

  final Socket _querySocket;
  final _querySocketData = StreamController<SocketEvent>.broadcast();
  QuerySocketManager(this._querySocket) {
    _querySocket.onAny((eventName, eventData) {
      if (eventData != null) {
        SocketEvent event = SocketEvent(name: eventName, jsonData: eventData);
        _querySocketData.sink
            .add(SocketEvent(name: eventName, jsonData: eventData));
        if (event.isRoomListEvent()) {
          _handleRoomListEvent(event);
        }
      }
    });
  }
  void _handleRoomListEvent(SocketEvent event) {
    if (event.name == WebsocketEvents.roomList) {
      final roomList =
          List.from(event.jsonData).map((e) => Room.fromJson(e)).toList();
      roomList$.add(roomList);
      _roomList = roomList;
    } else if (event.name == WebsocketEvents.newRoomItem) {
      final lastRoomList = _roomList;
      final RoomItem roomItem = RoomItem.fromJson(event.jsonData);
      final updatedRoom =
          lastRoomList.firstWhere((room) => room.id == roomItem.roomId);
      lastRoomList.remove(updatedRoom);
      updatedRoom.items = List.from([roomItem]);
      updatedRoom.hasUnreadMessage = true;
      lastRoomList.insert(0, updatedRoom);
      roomList$.add(lastRoomList);
    }
  }
}
