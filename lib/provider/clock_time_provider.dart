import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class ClockTimeProvider with ChangeNotifier {
  late String _formattedTime, _formattedDate;
  late Timer _timer;

  String get formattedTime => _formattedTime;
  String get formattedDate => _formattedDate;

  ClockTimeProvider() {
    final now = DateTime.now();
    _formattedTime = DateFormat('hh:mm:ss').format(DateTime.now());
    _formattedDate = DateFormat('dd/MM/yyyy a').format(now);
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    _formattedTime = DateFormat('hh:mm:ss').format(now);
    _formattedDate = DateFormat('dd/MM/yyyy a').format(now);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
