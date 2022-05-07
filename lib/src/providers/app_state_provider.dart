import 'dart:async';

import 'package:boochat_ui/src/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../shared/auth_bloc/auth_repository.dart';

class AppStateProvider {
  final appReady$ = StreamController<bool>.broadcast();
  late String _token;
  late Socket _commandSocket;
  late Socket _querySocket;
  var _commandSocketReady = false;
  var _querySocketReady = false;
  AppStateProvider();
  AppStateProvider.initialize(BuildContext context) {
    if (token == null) throw Exception("App State Init: failed to get token");
    appReady$.sink.add(false);
    _token = token;
    _commandSocket = _connectTo("${dotenv.env['COMMAND_URI']}");
    _querySocket = _connectTo("${dotenv.env['QUERY_URI']}");

    _commandSocket.onConnect((data) {
      _commandSocketReady = true;
      _command = CommandSocketManager(_commandSocket);
      _commandSocketReady = true;
      _checkIfAppReady();
    });
    _querySocket.onConnect((data) {
      _querySocketReady = true;
      _query = QuerySocketManager(_querySocket);
      _querySocketReady = true;
      _checkIfAppReady();
    });
  }

  Socket _connectTo(String uri) => io(
      uri,
      OptionBuilder()
          .setQuery({'token': _token}).setTransports(['websocket']).build());
  void _checkIfAppReady() {
    if (_commandSocketReady && _querySocketReady) {
      appReady$.sink.add(true);
    }
  }
}
