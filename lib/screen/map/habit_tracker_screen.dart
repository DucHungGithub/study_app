import 'package:flutter/material.dart';

class HabitTrackerScreen extends StatelessWidget {
  const HabitTrackerScreen({super.key});

  static const String routeName = '/habittrackerscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Habit Tracker Screen")),
    );
  }
}
