import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/custom_text_styles.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';
import 'package:study_app_project/controllers/question_page/questions_controller.dart';
import 'package:study_app_project/widgets/common/background_decoration.dart';
import 'package:study_app_project/widgets/common/custom_app_bar.dart';
import 'package:study_app_project/widgets/common/main_button.dart';
import 'package:study_app_project/widgets/content_area.dart';
import 'package:study_app_project/widgets/questions/answer_card.dart';
import 'package:study_app_project/widgets/questions/countdown_timer.dart';
import 'package:study_app_project/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});
  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: controller.completedTest),
      body: BackgroundDecoration(
          child: Column(children: [
        Expanded(
          child: ContentArea(
              child: Column(
            children: [
              Row(
                children: [
                  CountdownTimer(
                    time: '',
                    color: UIParameters.isDarkMode()
                        ? Theme.of(context).textTheme.bodyLarge!.color
                        : Theme.of(context).primaryColor,
                  ),
                  Obx(
                    () => Text(
                      '${controller.time} Remaining',
                      style: countDownTimerTs(),
                    ),
                  )
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
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (_, index) {
                      AnswerStatus? _answerStatus;
                      if (controller.allQuestions[index].selectedAnswer !=
                          null) {
                        _answerStatus = AnswerStatus.answered;
                      }
                      return QuestionNumberCard(
                          index: index + 1,
                          status: _answerStatus,
                          onTap: () => controller.jumpToQuestion(index)
                      );
                    }),
              )
            ],
          )),
        ),
        ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: UIParameters.mobileScreenPadding,
            child: MainButton(
              onTap: () {
                controller.complete();
              },
              title: 'Complete',
            )
          ),
        )
      ])),
    );
  }
}
