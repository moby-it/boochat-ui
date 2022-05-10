import 'package:boochat_ui/src/data/user.dart';

class UsersState {
  final List<User> allUsers;
  final List<String> activeUserIds;
  UsersState({required this.allUsers, required this.activeUserIds});
}
