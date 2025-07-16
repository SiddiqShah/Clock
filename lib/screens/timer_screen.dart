import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_set_go/provider/timer_provider.dart';
import 'package:time_set_go/widgets/bottom_navigation_bar.dart'
    show CustomBottomNavigationBar;

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  Future<void> _pickTime(BuildContext context) async {
    final provider = Provider.of<TimerProvider>(context, listen: false);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(minute: 1, hour: 0),
    );

    if (time != null) {
      Duration picked = Duration(minutes: time.minute + (time.hour * 60));
      provider.setTimer(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Timer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: Consumer<TimerProvider>(
        builder: (context, timer, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    formatDuration(timer.duration),
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "start_pause",
                      backgroundColor: const Color.fromARGB(255, 80, 80, 80),

                      child: Icon(
                        timer.isRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        timer.isRunning ? timer.pause() : timer.start();
                      },
                    ),
                    const SizedBox(width: 20),

                    if (!timer.isRunning)
                      ElevatedButton(
                        onPressed: () => _pickTime(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.grey, // Set background color here
                        ),
                        child: const Text(
                          "Set Timer",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: "reset",
                      backgroundColor: const Color.fromARGB(255, 80, 80, 80),

                      child: const Icon(Icons.restart_alt, color: Colors.blue),
                      onPressed: timer.reset,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
