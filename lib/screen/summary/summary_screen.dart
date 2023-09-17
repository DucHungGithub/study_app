import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/controllers/summary_controller.dart';
import 'package:study_app_project/widgets/common/background_decoration.dart';
import 'package:study_app_project/widgets/common/custom_app_bar.dart';

class SummaryScreen extends GetView<SummaryController> {
  const SummaryScreen({super.key});

  static const String routeName = '/summaryscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Subject Summary',
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Subject",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: onSurfaceTextColor),
                ),
                Text(
                  "Points",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: onSurfaceTextColor),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Expanded(
              child: FutureBuilder(
                future: controller.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.subjectMeans.length,
                        itemBuilder: (context, index) {
                          final entry =
                              controller.subjectMeans.entries.elementAt(index);
                          return ListTile(
                            leading: Text(
                              entry.key,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: onSurfaceTextColor),
                            ),
                            trailing: Text(
                              entry.value >= 0
                                  ? '${entry.value.toStringAsFixed(2)}'
                                  : '--',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: onSurfaceTextColor),
                            ),
                          );
                        },
                      );
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
