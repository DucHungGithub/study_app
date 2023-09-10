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
      appBar: AppBar(
        title: const Text('Habits'),
      ),
      body: Obx(() {
        final dateActivitiesMap = controller.getDateActivitiesMap();
        final startDate = createDateTimeObject(controller.startDate.value);
        return TrackerMap(datasets: dateActivitiesMap, startDate: startDate);
      }),
    );
  }
}
