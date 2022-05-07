import 'dart:io';

import 'package:boochat_ui/src/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'src/mobile.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      Provider(create: (context) => AppStateProvider(context))
    ],
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
