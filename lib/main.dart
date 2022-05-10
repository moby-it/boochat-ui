import 'dart:io';

import 'package:boochat_ui/src/app.dart';
import 'package:boochat_ui/src/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
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
