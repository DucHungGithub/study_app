import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';
import 'package:study_app_project/widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {Key? key,
      required this.index,
      required this.status,
      required this.onTap})
      : super(key: key);
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        backgroundColor = Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;

      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;

      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;

      case AnswerStatus.notanswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;

      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    return InkWell(
        onTap: onTap,
        borderRadius: UIParameters.cardBorderRadius,
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: UIParameters.cardBorderRadius,
          ),
          child: Center(
              child: Text(
            '$index',
            style: TextStyle(
                color: status == AnswerStatus.notanswered
                    ? Theme.of(context).primaryColor
                    : null),
          )),
        ));
  }
}
