import 'dart:io';

import 'package:boochat_ui/src/app.dart';
import 'package:boochat_ui/src/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(App(
      authRepository: AuthRepository(), websocketManager: WebsocketManager()));
}

String getEnvFilename() {
  if (kIsWeb) {
    return kDebugMode ? ".env" : "release.env";
  } else {
    if (Platform.isAndroid) return "android.env";
  }
  return ".env";
}
