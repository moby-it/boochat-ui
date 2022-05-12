import 'package:boochat_ui/src/data/notification.dart';

abstract class NotificationEvent {}

class SendNotificationEvent extends NotificationEvent {
  final Notification notification;
  SendNotificationEvent(this.notification);
}

class ClearNotifications extends NotificationEvent {}
