import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/controllers/question_page/questions_controller.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/models/datetime.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        remainSeconds /
        questionPaperModel.timeSeconds;
    return points.toStringAsFixed(2);
  }

  // Future<void> saveTestResults() async {
  //   var batch = fireStore.batch();
  //   User? user = Get.find<AuthController>().getUser();
  //   if (user == null) {
  //     return;
  //   }
  //   batch.set(
  //       userRF
  //           .doc(user.email)
  //           .collection('myRecent_tests')
  //           .doc(questionPaperModel.id),
  //       {
  //         "points": points,
  //         "correct_answer": '$correctQuestionCount / ${allQuestions.length}',
  //         "question_id": questionPaperModel.id,
  //         "time": questionPaperModel.timeSeconds - remainSeconds
  //       });
  //   batch.commit();
  //   navigateToHome();
  // }
  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) {
      return;
    }
    batch.set(
      userRF.doc(user.email).collection(questionPaperModel.id).doc(),
      {
        "point": points,
        "correct_question": correctQuestionCount,
        "total_question:": allQuestions.length,
        "question_id": questionPaperModel.id,
        "title": questionPaperModel.title,
        "time": questionPaperModel.timeSeconds - remainSeconds,
        "date": todaysDateFormatted(),
      },
    );
    batch.commit();
    navigateToHome();
  }
}
