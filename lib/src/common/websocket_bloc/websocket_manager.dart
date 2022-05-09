import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum WebsocketStatus { connecting, disconnected, connected }

class WebsocketManager {
  late final Socket commandSocket;
  late final Socket querySocket;
  bool _commandSocketConnected = false;
  bool _querySocketConnected = false;
  WebsocketStatus _status = WebsocketStatus.disconnected;
  get isConnecting => _status == WebsocketStatus.connecting;
  get isDisconnected => _status == WebsocketStatus.disconnected;
  get isConnected => _status == WebsocketStatus.connected;
  StreamController<bool> socketsConnected$ = StreamController<bool>.broadcast();
  WebsocketManager();
  void connect(String token) {
    _status = WebsocketStatus.connecting;
    commandSocket = _connectTo("${dotenv.env['COMMAND_URI']}", token);
    querySocket = _connectTo("${dotenv.env['QUERY_URI']}", token);
    querySocket.onConnect((data) {
      _querySocketConnected = true;
      if (_commandSocketConnected) {
        socketsConnected$.sink.add(true);
        _status = WebsocketStatus.connected;
      }
    });
    commandSocket.onConnect((data) {
      _commandSocketConnected = true;
      if (_querySocketConnected) {
        socketsConnected$.sink.add(true);
        _status = WebsocketStatus.connected;
      }
    });
  }

  Socket _connectTo(String uri, String token) => io(
      uri,
      OptionBuilder()
          .setQuery({'token': token}).setTransports(['websocket']).build());
}
