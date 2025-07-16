import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Duration _duration = Duration.zero;
  Timer? _timer;
  bool _isRunning = false;

  Duration get duration => _duration;
  bool get isRunning => _isRunning;

  void setTimer(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  void start() {
    if (_duration.inSeconds <= 0) return;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_duration.inSeconds > 0) {
        _duration -= Duration(seconds: 1);
      } else {
        _timer?.cancel();
        _isRunning = false;
      }
      notifyListeners();
    });
  }

  void pause() {
    _isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void reset() {
    _isRunning = false;
    _timer?.cancel();
    _duration = Duration.zero;
    notifyListeners();
  }
}
