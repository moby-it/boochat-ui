import 'package:equatable/equatable.dart';

import '../../data/data.dart';

abstract class ActiveRoomState extends Equatable {
  const ActiveRoomState();
  @override
  List<Object?> get props => [];
}

class NoActiveRoomSelectedState extends ActiveRoomState {
  const NoActiveRoomSelectedState();
  @override
  List<Object?> get props => [];
}

class ActiveRoomSelectedState extends ActiveRoomState {
  final Room room;
  const ActiveRoomSelectedState(this.room);
  @override
  List<Object?> get props => [room];
}
