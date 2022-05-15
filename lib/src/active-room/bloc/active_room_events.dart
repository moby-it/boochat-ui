import 'package:equatable/equatable.dart';

import '../../data/data.dart';

abstract class ActiveRoomEvent extends Equatable {
  const ActiveRoomEvent();
  @override
  List<Object?> get props => [];
}

class FetchingActiveRoomEvent extends ActiveRoomEvent {
  const FetchingActiveRoomEvent();
  @override
  List<Object?> get props => [];
}

class SelectActiveRoomEvent extends ActiveRoomEvent {
  final Room room;
  const SelectActiveRoomEvent(this.room);
  @override
  List<Object?> get props => [room];
}

class ClearActiveRoomEvent extends ActiveRoomEvent {
  const ClearActiveRoomEvent();
  @override
  List<Object?> get props => [];
}

class AppendRoomItemEvent extends ActiveRoomEvent {
  final RoomItem roomItem;
  const AppendRoomItemEvent(this.roomItem);
  @override
  List<Object?> get props => [roomItem];
}

class SendMessageEvent extends ActiveRoomEvent {
  final String content;
  const SendMessageEvent(this.content);
}
