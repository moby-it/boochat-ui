import 'dart:io';

import 'package:boochat_ui/src/app.dart';
import 'package:boochat_ui/src/core/core.dart';
import 'package:boochat_ui/src/data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  await Firebase.initializeApp(
    // name: "boochat-beta",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught errors from the framework to Crashlytics and initialize firebase channel.
  if (!kIsWeb && !kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await setAndroidNotificationChannel();
  }
  runApp(AppInitializer(
    authRepository: AuthRepository(),
    websocketManager: WebsocketManager(),
    roomRepository: RoomRepository(),
    child: const BoochatApp(),
  ));
}

String getEnvFilename() {
  if (kIsWeb) {
    return kDebugMode ? ".env" : "release.env";
  } else {
    if (Platform.isAndroid) return "android.env";
  }
  return ".env";
}

Future<void> setAndroidNotificationChannel() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const channel = AndroidNotificationChannel(
      'fcm_notification_channel', // id has to be registered at main/androidManifest.xml for receiving FCM messages
      'Cloud Messaging Notification Channel', // title
      description: 'Getting background messages from Firebase.', // description
      playSound: true,
      sound: RawResourceAndroidNotificationSound("notification"));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
