import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'src/shared/shared.dart';
import 'src/mobile.dart';

Future main() async {
  await dotenv.load(fileName: getEnvFilename());
  runApp(ChangeNotifierProvider(
    create: (context) => AppUserModel(),
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
