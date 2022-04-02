import 'package:flutter/material.dart';

abstract class BaseRemoteViewModel extends ChangeNotifier {

  Status _status = Status.initialized;

  Status currentStatus() {
    return _status;
  }

  void setStatus(Status newState) {
    _status = newState;
    notifyListeners();
  }

}

enum Status { initialized, loading, finished, error }