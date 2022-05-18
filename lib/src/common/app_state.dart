import 'package:flutter/cupertino.dart';

enum AppStatus { initializing, ready, error }

class AppState extends ChangeNotifier {
  Object? error;
  AppStatus _status = AppStatus.initializing;
  setStatus(AppStatus status, Object? error) {
    _status = status;
    if (error != null) {
      this.error = error;
    }
    notifyListeners();
  }

  bool get isReady => _status == AppStatus.ready;
  bool get initializing => _status == AppStatus.initializing;
}
