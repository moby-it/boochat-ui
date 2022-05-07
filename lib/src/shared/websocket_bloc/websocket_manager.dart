import 'package:socket_io_client/socket_io_client.dart';

class WsManager {
  late Socket _commandSocket;
  late Socket _querySocket;
  bool _commandSocketReady = false;
  bool _querySocketReady = false;

  Socket _connectTo(String uri) => io(
      uri,
      OptionBuilder()
          .setQuery({'token': _token}).setTransports(['websocket']).build());
}
