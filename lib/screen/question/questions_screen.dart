import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_app_project/screen/home/question_card.dart';
import 'package:study_app_project/widgets/common/background_decoration.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  static const String routeName = "/questionsscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundDecoration(child: Center(child: Text("Here"))));
  }
}
