import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/summary_controller.dart';

class SummaryScreen extends GetView<SummaryController> {
  const SummaryScreen({super.key});

  static const String routeName = '/summaryscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Summary'),
      ),
      body: FutureBuilder(
        future: controller.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(() {
              return ListView.builder(
                itemCount: controller.subjectMeans.length,
                itemBuilder: (context, index) {
                  final entry =
                      controller.subjectMeans.entries.elementAt(index);
                  return ListTile(
                    leading: Text(entry.key),
                    title: Text(
                        entry.value >= 0 ? 'Mean point: ${entry.value}' : '--'),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}
