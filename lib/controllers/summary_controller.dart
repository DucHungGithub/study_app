import 'package:get/get.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/firebase_ref/references.dart';

class SummaryController extends GetxController {
  final String _userMail =
      Get.find<AuthController>().getUser()!.email.toString();
  final RxMap<String, double> subjectMeans = <String, double>{}.obs;
  //final RxList<String> subjects = <String>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    final questionPapersSnapshot = await questionPaperRF.get();

    for (var doc in questionPapersSnapshot.docs) {
      final id = doc.id;
      final title = doc.data()['title'] as String;
      //subjects.add(title);

      final subjectRef = userRF.doc(_userMail).collection(id);
      final subjectsSnapshot = await subjectRef.get();

      int length = 0;
      double points = 0;
      for (var subjectDoc in subjectsSnapshot.docs) {
        final point = subjectDoc.data()['point'] as String;
        length++;
        points += double.parse(point);
      }
      if (length == 0) {
        subjectMeans[title] = -1;
      } else {
        final mean = points / length;
        subjectMeans[title] = mean;
      }
    }
  }

  // Future<void> fetchSubjectMeans() async {
  //   final userRef = userRF.doc(_userMail);
  //   final subjectsSnapshot = await userRef.collection('subject_id').get();

  //   for (var elem in subjects) {
  //     final subjectRef = userRef.collection(elem);
  //     final subjectsSnapshot = await subjectRef.get();

  //     subjectsSnapshot.docs.forEach((subjectDoc) {
  //       final points = subjectDoc.data()['points'] as List<String>;
  //       final meanPoint =
  //           points.map(double.parse).reduce((a, b) => a + b) / points.length;
  //       subjectMeans[elem] = meanPoint;
  //     });
  //   }
  // }
}
