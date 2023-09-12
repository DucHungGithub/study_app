import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/models/datetime.dart';

import 'auth_controller.dart';

class HabitController extends GetxController {
  final String _userMail =
      Get.find<AuthController>().getUser()!.email.toString();
  RxList<DateActivity> dateActivities =
      <DateActivity>[].obs; //late Map<DateTime, int>? _databases;

  RxString startDate = ''.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    final activityRef = activityRF.doc(_userMail);
    final activitySnapshot = await activityRef.get();
    if (activitySnapshot.exists) {
      startDate.value = activitySnapshot['startDate'];
      final dateActivityQuerySnapshot =
          await activityRef.collection('DateActivity').get();
      dateActivities.value = dateActivityQuerySnapshot.docs
          .map((doc) => DateActivity.fromDocument(doc))
          .toList();
    }
  }

  Future<void> addHabit() async {
    final activityRef = activityRF
        .doc(_userMail)
        .collection('DateActivity')
        .doc(todaysDateFormatted());

    activityRef.get().then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        activityRef.update({'completed': FieldValue.increment(1)});
      } else {
        activityRef.set(
          {
            'date': todaysDateFormatted(),
            'completed': 1,
            'dummy_field': null,
          },
        ); // create the document
      }
    });
  }

  Map<DateTime, int> getDateActivitiesMap() {
    return dateActivities.fold<Map<DateTime, int>>({}, (map, dateActivity) {
      DateTime date = createDateTimeObject(dateActivity.date);
      map[date] = dateActivity.completed;
      return map;
    });
  }
}

class DateActivity {
  final String date;
  final int completed;

  DateActivity({required this.date, required this.completed});

  factory DateActivity.fromDocument(DocumentSnapshot doc) {
    return DateActivity(
      date: doc['date'],
      completed: doc['completed'],
    );
  }
}
