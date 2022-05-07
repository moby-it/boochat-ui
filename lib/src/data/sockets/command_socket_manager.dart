import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../data.dart';

class CommandSocketManager {
  final Socket _commandSocket;
  final _commandSocketData = StreamController<SocketEvent>.broadcast();
  CommandSocketManager(this._commandSocket);
}
