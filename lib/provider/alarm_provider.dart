import 'package:flutter/material.dart';

class AlarmProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _alarms = [];

  List<Map<String, dynamic>> get alarms => _alarms;

  void addAlarm(TimeOfDay time, String label) {
    _alarms.add({'time': time, 'label': label, 'isActive': true});
    notifyListeners();
  }

  void toggleAlarm(int index, bool isActive) {
    _alarms[index]['isActive'] = isActive;
    notifyListeners();
  }

  void deleteAlarm(int index) {
    _alarms.removeAt(index);
    notifyListeners();
  }
}
