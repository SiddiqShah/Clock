import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_set_go/provider/navigation_provider.dart';
import 'package:time_set_go/screens/alarm_screen.dart';
import 'package:time_set_go/screens/clock_screen.dart';
import 'package:time_set_go/screens/stopwatch_screen.dart';
import 'package:time_set_go/screens/timer_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  void _navigate(BuildContext context, int index) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setIndex(index);

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const AlarmScreen();
        break;
      case 1:
        targetScreen = const HomeScreen();
        break;
      case 2:
        targetScreen = const StopwatchScreen();
        break;
      case 3:
        targetScreen = const TimerScreen();
        break;
      default:
        targetScreen = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = Provider.of<NavigationProvider>(
      context,
    ).selectedIndex;

    return Container(
      height: 80,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(context, Icons.alarm, 0, selectedIndex, 'Alaram'),
          _buildIcon(
            context,
            Icons.access_time_filled,
            1,
            selectedIndex,
            'Clock',
          ),
          _buildIcon(context, Icons.timer, 2, selectedIndex, 'Stopwatch'),
          _buildIcon(
            context,
            Icons.hourglass_bottom,
            3,
            selectedIndex,
            'Timer',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(
    BuildContext context,
    IconData icon,
    int index,
    int selectedIndex,
    String label,
  ) {
    return GestureDetector(
      onTap: () => _navigate(context, index),
      child: Column(
        children: [
          Icon(
            icon,
            color: selectedIndex == index
                ? Colors.white
                : const Color.fromARGB(255, 97, 97, 97),
            size: 30,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index
                  ? Colors.white
                  : const Color.fromARGB(255, 97, 97, 97),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
