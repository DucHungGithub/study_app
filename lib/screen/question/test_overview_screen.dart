import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/custom_text_styles.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';
import 'package:study_app_project/controllers/question_page/questions_controller.dart';
import 'package:study_app_project/screen/home/question_card.dart';
import 'package:study_app_project/widgets/common/background_decoration.dart';
import 'package:study_app_project/widgets/common/custom_app_bar.dart';
import 'package:study_app_project/widgets/content_area.dart';
import 'package:study_app_project/widgets/questions/countdown_timer.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});

  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                    child: Column(
              children: [
                Row(
                  children: [
                    CountdownTimer(
                      color: UIParameters.isDarkMode()
                          ? Theme.of(context).textTheme.bodyText1!.color
                          : Theme.of(context).primaryColor,
                      time: '',
                    ),
                    Obx(() => Text(
                          '${controller.time} Remaining',
                          style: countDownTimerTS(),
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.allQuestions.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width ~/ 75,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (_, index) {
                      return Text(
                        '${controller.allQuestions[index].selectedAnswer != null}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    },
                  ),
                )
              ],
            )))
          ],
        ),
      ),
    );
  }
}
