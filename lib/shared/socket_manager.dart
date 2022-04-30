import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketEvent {
  const SocketEvent({required this.name, required this.jsonData});
  final String name;
  final List<dynamic> jsonData;
}

class SocketManager extends ChangeNotifier {
  final _querySocketData = StreamController<SocketEvent>();
  late String _token;
  late Socket _commandSocket;
  late Socket _querySocket;
  var _commandSocketReady = false;
  var _querySocketReady = false;
  get initialized => _commandSocketReady && _querySocketReady;
  Stream<SocketEvent> get queryStream => _querySocketData.stream;

  SocketManager(String token) {
    _token = token;
    _commandSocket = _connectTo("${dotenv.env['COMMAND_URI']}");
    _querySocket = _connectTo("${dotenv.env['QUERY_URI']}");
    _commandSocket.onConnect((data) {
      _commandSocketReady = true;
      notifyListeners();
    });
    _querySocket.onConnect((data) {
      _querySocketReady = true;
      notifyListeners();
    });
    _querySocket.onAny((event, data) {
      if (data != null) {
        _querySocketData.sink.add(SocketEvent(name: event, jsonData: data));
      }
    });
  }

  Socket _connectTo(String uri) => io(
      uri,
      OptionBuilder()
          .setQuery({'token': _token}).setTransports(['websocket']).build());
}
