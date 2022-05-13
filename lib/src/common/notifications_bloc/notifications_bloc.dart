import 'dart:async';
import 'dart:math';

import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/common/notifications_bloc/notifications_events.dart';
import 'package:boochat_ui/src/common/notifications_bloc/notifications_state.dart';
import 'package:boochat_ui/src/data/data.dart' as models;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsBloc extends Bloc<NotificationEvent, NotificationsState> {
  final WebsocketManager _websocketManager;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final onNewNotification$ = StreamController<AndroidNotificationDetails>();
  NotificationsBloc(this._websocketManager)
      : super(const NotificationsState()) {
    _websocketManager.socketsConnected$.stream.listen((connected) {
      if (connected) {
        _websocketManager.querySocket.on(WebsocketEvent.newRoomItem,
            (data) async {
          models.RoomItem roomItem;
          if (data['sender'] != null) {
            roomItem = models.Message.fromJson(data);
          } else {
            roomItem = models.Announcement.fromJson(data);
          }
          final notification = models.Notification(
              content: roomItem.content,
              title: "New Message",
              dateTime: roomItem.dateSent);
          const androidNotificationDetails = AndroidNotificationDetails(
            "2",
            "query_socket.new_room_item",
            sound: RawResourceAndroidNotificationSound("notification"),
            playSound: true,
            enableVibration: true,
          );
          await _flutterLocalNotificationsPlugin.show(
              Random().nextInt(10),
              notification.title,
              notification.content,
              const NotificationDetails(android: androidNotificationDetails));
        });
      }
    });
  }
  Future<bool> initializeNotificationSettings() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings("app_icon");
      const initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (payload) => print("Notification Selected"));
      final fcmToken = FirebaseMessaging.instance.getToken();
      print(await fcmToken);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
