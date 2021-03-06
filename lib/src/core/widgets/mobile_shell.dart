import 'package:boochat_ui/src/routes/router.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

class MobileApp extends StatelessWidget {
  const MobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BoochatTheme.darkTheme,
      routeInformationParser: mobileRouter.routeInformationParser,
      routerDelegate: mobileRouter.routerDelegate,
    );
  }
}
