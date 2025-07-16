import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_set_go/widgets/bottom_navigation_bar.dart';
import 'package:time_set_go/provider/stopwatch_provider.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    final hundredths = twoDigits((d.inMilliseconds.remainder(1000)) ~/ 10);
    return '$minutes:$seconds:$hundredths';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Stopwatch",
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
      body: Consumer<StopwatchProvider>(
        builder: (context, stopwatch, _) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    formatDuration(stopwatch.duration),
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "start_pause",
                      backgroundColor: const Color.fromARGB(255, 80, 80, 80),
                      foregroundColor: Colors.blue,
                      child: Icon(
                        stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () {
                        stopwatch.isRunning
                            ? stopwatch.pause()
                            : stopwatch.start();
                      },
                    ),
                    const SizedBox(width: 100),
                    FloatingActionButton(
                      heroTag: "reset",
                      backgroundColor: const Color.fromARGB(255, 80, 80, 80),
                      child: const Icon(Icons.restart_alt, color: Colors.blue),
                      onPressed: stopwatch.reset,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
