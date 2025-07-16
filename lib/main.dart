import 'package:flutter/material.dart';
import 'package:time_set_go/provider/alarm_provider.dart';
import 'package:time_set_go/provider/navigation_provider.dart';
import 'package:time_set_go/provider/stopwatch_provider.dart';
import 'package:time_set_go/provider/clock_time_provider.dart';
import 'package:time_set_go/provider/timer_provider.dart';
import 'package:time_set_go/screens/clock_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClockTimeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => StopwatchProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => AlarmProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
