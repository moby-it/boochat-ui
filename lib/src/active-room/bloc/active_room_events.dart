import 'package:equatable/equatable.dart';

import '../../data/data.dart';

abstract class ActiveRoomEvent extends Equatable {
  const ActiveRoomEvent();
  @override
  List<Object?> get props => [];
}

class SelectActiveRoomEvent extends ActiveRoomEvent {
  final Room room;
  const SelectActiveRoomEvent(this.room);
  @override
  List<Object?> get props => [];
}

class ClearActiveRoomEvent extends ActiveRoomEvent {
  const ClearActiveRoomEvent();
  @override
  List<Object?> get props => [];
}
