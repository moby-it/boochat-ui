import 'package:flutter/material.dart';

import '../web_screens/main_web_screen.dart';

Map<String, WidgetBuilder> webRoutes() {
  return Map.from({
    '/': (context) => const MainWebScreen(),
  });
}
