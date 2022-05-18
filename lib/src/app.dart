import 'package:boochat_ui/src/layout_widgets/web_shell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'layout_widgets/mobile_shell.dart';

class BoochatApp extends StatelessWidget {
  const BoochatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const WebShell() : const MobileShell();
  }
}
