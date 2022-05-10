import 'package:boochat_ui/src/data/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
  @override
  List<Object?> get props => [];
}

class UpdateAllUsersEvent extends UsersEvent {
  final List<User> allUsers;
  const UpdateAllUsersEvent(this.allUsers);
}

class UpdateActiveUsersEvent extends UsersEvent {
  final List<String> activeUserIds;
  const UpdateActiveUsersEvent(this.activeUserIds);
}
