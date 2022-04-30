import 'dart:io';

import 'package:boochat_ui/mobile.dart';
import 'package:boochat_ui/shared/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleUserModel(),
    // child: Platform.isAndroid?  const BoochatMobileApp(): const WebApp(),
    child: const BoochatMobileApp(),
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
