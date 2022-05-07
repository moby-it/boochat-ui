import 'dart:io';

import 'package:boochat_ui/src/shared/auth_bloc/auth_repository.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/mobile_app.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  runApp(MobileApp(
    authRepository: AuthRepository(),
    websocketManager: WebsocketManager(),
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
