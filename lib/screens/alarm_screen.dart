import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_set_go/widgets/bottom_navigation_bar.dart';
import 'package:time_set_go/screens/add_alarm_screen.dart';
import 'package:time_set_go/provider/alarm_provider.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Alarm",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert, size: 20, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: Consumer<AlarmProvider>(
        builder: (context, alarmProvider, child) {
          final alarms = alarmProvider.alarms;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Alarm",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ...alarms.asMap().entries.map((entry) {
                  int index = entry.key;
                  var alarm = entry.value;
                  final time = alarm['time'] as TimeOfDay;
                  final label = alarm['label'] as String;
                  final isActive = alarm['isActive'] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.grey[900] : Colors.grey[850],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              time.format(context),
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (label.isNotEmpty)
                              Text(
                                label,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.grey
                                      : Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                        Column(
                          children: [
                            Switch(
                              value: isActive,
                              onChanged: (val) {
                                alarmProvider.toggleAlarm(index, val);
                              },
                              activeColor: Colors.blue,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                alarmProvider.deleteAlarm(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 78, 78, 78),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAlarmScreen()),
          );

          if (result != null &&
              result is Map<String, dynamic> &&
              result['time'] != null) {
            Provider.of<AlarmProvider>(
              context,
              listen: false,
            ).addAlarm(result['time'], result['label'] ?? '');
          }
        },
        child: const Icon(Icons.add, size: 30, color: Colors.blue),
        shape: const CircleBorder(),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
