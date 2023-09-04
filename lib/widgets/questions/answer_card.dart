import 'package:flutter/material.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswerCard({Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected
            ? answerSelectedColor()
            : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected
              ? answerSelectedColor()
              : answerBorderColor(),
          )
        ),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,

          ),
        ),
      ),
    );
  }
}