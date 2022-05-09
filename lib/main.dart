import 'dart:io';

import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/web_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/mobile_app.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  final app = kIsWeb
      ? WebApp(
          authRepository: AuthRepository(),
          websocketManager: WebsocketManager())
      : MobileApp(
          authRepository: AuthRepository(),
          websocketManager: WebsocketManager());
  runApp(app);
}

String getEnvFilename() {
  if (kIsWeb) {
    return kDebugMode ? ".env" : "release.env";
  } else {
    if (Platform.isAndroid) return "android.env";
  }
  return ".env";
}
