import 'package:boochat_ui/src/active_room/active_room.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class WebRoutePath {
  String? selectedRoomId;
  final bool isCreateRoomPage;
  WebRoutePath.initial()
      : isCreateRoomPage = false,
        selectedRoomId = null;
  WebRoutePath.activeRoom(this.selectedRoomId) : isCreateRoomPage = false;
  WebRoutePath.createRoom()
      : isCreateRoomPage = true,
        selectedRoomId = null;
  @override
  bool operator ==(Object other) =>
      other is WebRoutePath &&
      other.selectedRoomId == selectedRoomId &&
      other.isCreateRoomPage == isCreateRoomPage;
  @override
  int get hashCode => hash2(
        selectedRoomId,
        isCreateRoomPage,
      );
}

class WebRouteInformationParser extends RouteInformationParser<WebRoutePath> {
  @override
  Future<WebRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.path.contains(RouteNames.room) && uri.pathSegments.length >= 2) {
      var roomId = uri.pathSegments[1];
      return WebRoutePath.activeRoom(roomId);
    } else if (uri.path == RouteNames.createRoom) {
      return WebRoutePath.createRoom();
    } else {
      return WebRoutePath.initial();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(WebRoutePath configuration) {
    if (configuration.selectedRoomId != null) {
      return RouteInformation(
          location: "/${RouteNames.room}/${configuration.selectedRoomId}");
    } else if (configuration.isCreateRoomPage) {
      return const RouteInformation(location: RouteNames.createRoom);
    } else {
      return const RouteInformation(location: '/');
    }
  }
}

class WebRouterDelegete extends RouterDelegate<WebRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WebRoutePath> {
  String? roomId;
  bool isCreateRoom = false;
  final RouteState state;
  WebRouterDelegete(this.state) {
    state.addListener(notifyListeners);
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [ActiveRoomSubpage(roomId), if (isCreateRoom) CreateRoomSubpage()],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          notifyListeners();
          return false;
        } else {
          return true;
        }
      },
    );
  }

  @override
  WebRoutePath get currentConfiguration {
    if (isCreateRoom) {
      return WebRoutePath.createRoom();
    } else {
      return WebRoutePath.activeRoom(roomId);
    }
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(WebRoutePath configuration) async {
    if (configuration.selectedRoomId != null) {
      roomId = configuration.selectedRoomId;
    } else if (configuration.isCreateRoomPage) {
      isCreateRoom = true;
    }
  }

  @override
  void dispose() {
    state.removeListener(notifyListeners);
    state.dispose();
    super.dispose();
  }
}

class ActiveRoomSubpage extends Page {
  final String? roomId;
  const ActiveRoomSubpage(this.roomId);
  @override
  Route createRoute(BuildContext context) {
    return NoAnimatePageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) =>
            ActiveRoom(roomId: roomId));
  }
}

class CreateRoomSubpage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return NoAnimatePageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CreateRoom());
  }
}

class NoAnimatePageRouteBuilder extends PageRouteBuilder {
  NoAnimatePageRouteBuilder(
      {required RouteSettings settings, required RoutePageBuilder pageBuilder})
      : super(
            pageBuilder: pageBuilder,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            settings: settings);
}

class RouteState extends ChangeNotifier {
  final WebRouteInformationParser _parser;
  WebRoutePath _path;
  RouteState(this._parser) : _path = WebRoutePath.activeRoom(null);
  set path(WebRoutePath path) {
    if (_path == path) return;
    _path = path;
    notifyListeners();
  }

  Future<void> go(String route) async {
    path =
        await _parser.parseRouteInformation(RouteInformation(location: route));
  }
}

class RouteStateScope extends InheritedNotifier<RouteState> {
  const RouteStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static RouteState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RouteStateScope>()!.notifier!;
}
