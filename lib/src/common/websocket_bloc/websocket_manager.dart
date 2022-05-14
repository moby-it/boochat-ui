import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
  final StreamController<bool> _socketsConnected$ =
      StreamController<bool>.broadcast();
  get socketsConnected$ => _socketsConnected$.stream;
  WebsocketManager();
  Future<void> connect(String token) async {
    _status = WebsocketStatus.connecting;
    commandSocket = await _connectTo("${dotenv.env['COMMAND_URI']}", token);
    querySocket = await _connectTo("${dotenv.env['QUERY_URI']}", token);
    querySocket.onConnect((data) {
      _querySocketConnected = true;
      _checkIfSocketsReady();
    });
    commandSocket.onConnect((data) {
      _commandSocketConnected = true;
      _checkIfSocketsReady();
    });
  }

  Future<Socket> _connectTo(String uri, String token) async {
    if (!kIsWeb) {
      final registrationToken = await FirebaseMessaging.instance.getToken();
      print("Registration token: $registrationToken");
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        print("token refreshed: $token");
      });
      return io(
          uri,
          OptionBuilder().setQuery({
            'token': token,
            'registrationToken': registrationToken
          }).setTransports(['websocket']).build());
    } else {
      return io(
          uri,
          OptionBuilder().setQuery({
            'token': token,
          }).setTransports(['websocket']).build());
    }
  }

  _checkIfSocketsReady() {
    if (_commandSocketConnected && _querySocketConnected) {
      _socketsConnected$.sink.add(true);
      _status = WebsocketStatus.connected;
    }
  }
}
