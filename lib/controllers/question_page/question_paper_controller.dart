import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/models/question_paper_model.dart';
import 'package:study_app_project/screen/question/questions_screen.dart';
import 'package:study_app_project/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        String paperLink = paper.title.replaceAll(" ", "_");
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paperLink);
        paper.imageUrl = imgUrl;
        print(paper.imageUrl);
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (authController.isLogged()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionsScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialog();
    }
  }
}
