import 'package:boochat_ui/src/active_room/active_room.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';

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
}

class WebRouteInformationParser extends RouteInformationParser<WebRoutePath> {
  @override
  Future<WebRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.path.length >= 2) {
      var roomId = uri.pathSegments[1];
      return WebRoutePath.activeRoom(roomId);
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
    }
    return null;
  }
}

class WebRouterDelegete extends RouterDelegate<WebRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WebRoutePath> {
  String? roomId;
  bool isCreateRoom = false;
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
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(WebRoutePath configuration) async {
    if (configuration.selectedRoomId != null) {
      roomId = configuration.selectedRoomId;
    } else if (configuration.isCreateRoomPage) {
      isCreateRoom = true;
    }
  }

  handleRoomTapped(String roomId) {
    this.roomId = roomId;
    isCreateRoom = false;
    notifyListeners();
  }

  handleCreateRoomTapped() {
    isCreateRoom = true;
    roomId = null;
    notifyListeners();
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
