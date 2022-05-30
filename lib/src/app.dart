import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';

class BoochatApp extends StatelessWidget {
  const BoochatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const WebApp() : const MobileApp();
  }
}
