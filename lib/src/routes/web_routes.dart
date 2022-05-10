import 'package:flutter/cupertino.dart';

import '../web_screens/main_web_screen.dart';

Map<String, WidgetBuilder> webRoutes() {
  return Map.from({
    '/': (context) => const MainWebScreen(),
  });
}
