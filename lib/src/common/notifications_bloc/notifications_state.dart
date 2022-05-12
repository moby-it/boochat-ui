import 'package:boochat_ui/src/data/notification.dart';

class NotificationsState {
  final List<Notification> notifications;
  const NotificationsState() : notifications = const [];
  const NotificationsState.update(this.notifications);
}
