import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/habit_controller.dart';
import 'package:study_app_project/models/datetime.dart';
import 'package:study_app_project/widgets/tracker_map.dart';

class HabitTrackerScreen extends GetView<HabitController> {
  const HabitTrackerScreen({super.key});

  static const String routeName = '/habittrackerscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Habits',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: controller.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final dateActivitiesMap = controller.getDateActivitiesMap();
            final startDate = createDateTimeObject(controller.startDate.value);
            return TrackerMap(
                datasets: dateActivitiesMap, startDate: startDate);
          }
        },
      ),
    );
  }
}
