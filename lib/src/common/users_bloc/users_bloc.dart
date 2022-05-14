import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final WebsocketManager _websocketManager;
  UsersBloc(this._websocketManager)
      : super(UsersState(allUsers: List.empty(), activeUserIds: List.empty())) {
    on<UpdateActiveUsersEvent>(_updateActiveUsersHandler);
    on<UpdateAllUsersEvent>(_updateAllUsersHandler);
    _websocketManager.socketsConnected$.listen((connected) {
      if (connected) {
        _websocketManager.querySocket.onAny(_handleQuerySocketEvent);
      }
    });
  }
  _updateAllUsersHandler(UpdateAllUsersEvent event, Emitter<UsersState> emit) {
    emit(UsersState(
        allUsers: event.allUsers, activeUserIds: state.activeUserIds));
  }

  _updateActiveUsersHandler(
      UpdateActiveUsersEvent event, Emitter<UsersState> emit) {
    emit(UsersState(
        allUsers: state.allUsers, activeUserIds: event.activeUserIds));
  }

  _handleQuerySocketEvent(String event, dynamic data) {
    if (event == WebsocketEvents.allUsers) {
      final List<User> users =
          List.from(data).map((json) => User.fromJson(json)).toList();
      add(UpdateAllUsersEvent(users));
    } else if (event == WebsocketEvents.activeUserList) {
      final List<String> activeUserIds = List.from(data);
      add(UpdateActiveUsersEvent(activeUserIds));
    }
  }
}
