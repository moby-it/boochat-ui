import '../../data/data.dart';

abstract class ActiveRoomState {
  const ActiveRoomState();
}

class NoActiveRoomSelectedState extends ActiveRoomState {
  const NoActiveRoomSelectedState();
}

class ActiveRoomSelectedState extends ActiveRoomState {
  final Room room;
  const ActiveRoomSelectedState(this.room);
}

class FetchingActiveRoomState extends ActiveRoomState {
  const FetchingActiveRoomState();
}
