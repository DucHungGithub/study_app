import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/firebase_ref/loading_status.dart';

import 'data_uploader.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});

  final DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "Uploading completed"
                : "Uploading...")),
      ),
    );
  }
}
