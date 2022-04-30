import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketManager extends ChangeNotifier {
  late String _token;
  late Socket _commandSocket;
  late Socket _querySocket;
  var _commandSocketReady = false;
  var _querySocketReady = false;
  get initialized => _commandSocketReady && _querySocketReady;
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
  }

  Socket _connectTo(String uri) {
    return io(
        uri,
        OptionBuilder()
            .setQuery({'token': _token}).setTransports(['websocket']).build());
  }
}
