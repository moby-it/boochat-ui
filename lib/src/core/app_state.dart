import 'package:flutter/cupertino.dart';

enum AppStatus { initializing, ready, error }

class AppState extends ChangeNotifier {
  Object? error;
  AppStatus status = AppStatus.initializing;
  setStatus(AppStatus status, Object? error) {
    this.status = status;
    if (error != null) {
      this.error = error;
    }
    notifyListeners();
  }
}
