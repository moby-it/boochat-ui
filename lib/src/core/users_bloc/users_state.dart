import 'package:boochat_ui/src/data/data.dart';

class UsersState {
  final List<User> allUsers;
  final List<String> activeUserIds;
  UsersState({required this.allUsers, required this.activeUserIds});
  bool userIsOnline(String userId) {
    return activeUserIds.contains(userId);
  }
}
