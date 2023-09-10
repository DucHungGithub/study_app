import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/controllers/habit_controller.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/widgets/tracker_map.dart';

class HabitTrackerScreen extends GetView<HabitController> {
  const HabitTrackerScreen({super.key});

  static const String routeName = '/habittrackerscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habits'),
      ),
      body: Obx(() {
        final dateActivitiesMap = controller.getDateActivitiesMap();
        return Column(
          children: [
            Text('Start Date: ${controller.startDate}'),
            Expanded(
              child: ListView.builder(
                itemCount: dateActivitiesMap.length,
                itemBuilder: (context, index) {
                  final entry = dateActivitiesMap.entries.elementAt(index);
                  return ListTile(
                    title: Text(entry.key.toString()),
                    trailing: Text(entry.value.toString()),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

// body: FutureBuilder(
//         future: habitController.startDate,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               String startDate = snapshot.data['startDate'] as String;
//               return Text('startDate: $startDate');
//             } else if (snapshot.hasError)
//               return Text('Error = ${snapshot.error}');
//             else
//               return Text('Something went wrong: ${userMail}');
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),