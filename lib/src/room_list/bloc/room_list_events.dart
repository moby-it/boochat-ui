import 'package:equatable/equatable.dart';

import '../../data/data.dart';

abstract class RoomListEvent extends Equatable {
  const RoomListEvent();
  @override
  List<Object?> get props => [];
}

class UpdateRoomListEvent extends RoomListEvent {
  final List<Room> rooms;
  const UpdateRoomListEvent(this.rooms);
  @override
  List<Object?> get props => [rooms];
}
