import 'package:flutter/foundation.dart';
import 'dart:async';

class StopwatchProvider with ChangeNotifier {
  Duration _duration = Duration.zero;
  Timer? _timer;
  bool _isRunning = false;

  Duration get duration => _duration;
  bool get isRunning => _isRunning;

  void start() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(milliseconds: 10), (_) {
      _duration += Duration(milliseconds: 10);
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
