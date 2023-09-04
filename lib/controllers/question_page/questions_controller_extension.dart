import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/controllers/question_page/questions_controller.dart';
import 'package:study_app_project/firebase_ref/references.dart';

extension QuestionsControllerExtension on QuestionsController {
  
  int get correctQuestionCount => allQuestions
    .where((element) => element.selectedAnswer == element.correctAnswer)
    .toList()
    .length;
  
  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) * 100 *
    (questionPaperModel.timeSeconds - remainSeconds) / questionPaperModel.timeSeconds * 100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null)
      return;
    batch.set(
      userRF.doc(_user.email).collection('myrecent_tests').doc(questionPaperModel.id),
      {
        "points": points,
        "correct_answer": '$correctQuestionCount / ${allQuestions.length}',
        "question_id": questionPaperModel.id,
        "time": questionPaperModel.timeSeconds - remainSeconds
      }
    );
    batch.commit();
    navigateToHome();
  }
}