import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/controllers/habit_controller.dart';
import 'package:study_app_project/models/datetime.dart';
import 'package:study_app_project/widgets/common/background_decoration.dart';
import 'package:study_app_project/widgets/common/custom_app_bar.dart';
import 'package:study_app_project/widgets/tracker_map.dart';

class HabitTrackerScreen extends GetView<HabitController> {
  const HabitTrackerScreen({super.key});

  static const String routeName = '/habittrackerscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Activity',
      ),
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        child: FutureBuilder(
          future: controller.fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final dateActivitiesMap = controller.getDateActivitiesMap();
              final startDate =
                  createDateTimeObject(controller.startDate.value);
              return TrackerMap(
                  datasets: dateActivitiesMap, startDate: startDate);
            }
          },
        ),
      ),
    );
  }
}
