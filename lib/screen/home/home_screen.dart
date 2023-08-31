import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';
import 'package:study_app_project/controllers/question_page/question_paper_controller.dart';
import 'package:study_app_project/screen/home/question_card.dart';
import 'package:study_app_project/widgets/content_area.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: ContentArea(
        child: Obx(() => ListView.separated(
              padding: UIParameters.mobileScreenPadding,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return QuestionCard(
                  model: _questionPaperController.allPapers[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
              itemCount: _questionPaperController.allPapers.length,
            )),
      ),
    );
  }
}
