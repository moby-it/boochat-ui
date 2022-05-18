import 'package:boochat_ui/src/routes/route_generator.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileShell extends StatelessWidget {
  const MobileShell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BoochatTheme.darkTheme,
      onGenerateRoute: RouteGenerator.generateMobileRoute,
      builder: (context, navigator) =>
          SafeArea(child: Scaffold(body: Container(child: navigator))),
    );
  }
}
