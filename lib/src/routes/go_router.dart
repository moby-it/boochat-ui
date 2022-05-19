import 'package:boochat_ui/src/layout_widgets/web_screen.dart';
import 'package:go_router/go_router.dart';

final webRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const WebScreen(), routes: [])
]);
