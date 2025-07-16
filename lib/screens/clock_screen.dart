import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_set_go/widgets/bottom_navigation_bar.dart';
import 'package:time_set_go/provider/clock_time_provider.dart';
import 'package:analog_clock/analog_clock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("build"); // Only prints once unless other state changes

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: const Text(
            "Clock",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert, size: 20, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: Consumer<ClockTimeProvider>(
        builder: (context, timeProvider, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80),
          child: Column(
            children: [
              Center(
                child: Text(
                  timeProvider.formattedTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Current: ${timeProvider.formattedDate}',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 60),
              AnalogClock(
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: Colors.grey),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                width: 250.0,
                height: 250.0,
                isLive: true,
                hourHandColor: Colors.white,
                minuteHandColor: Colors.white70,
                showSecondHand: true,
                secondHandColor: Colors.red,
                numberColor: Colors.white,
                showNumbers: true,
                textScaleFactor: 1.4,
                showTicks: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
