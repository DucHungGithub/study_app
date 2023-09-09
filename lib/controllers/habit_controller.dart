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
  void onReady() {
    _fetchData();
    super.onReady();
  }

  // void initHabit() {
  //   loadStartDate(_userMail);

  //   //loadDatabase(_user.email.toString());
  // }

  void _fetchData() async {
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

  // Future<void> loadStartDate(String email) async {
  //   _startDate = await activityRF
  //       .doc(email)
  //       .get()
  //       .then((value) => value.data()!['startDate']) as String;
  // }

  // Future<void> loadDatabase(String email) async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot =
  //       await activityRF.doc(_userMail).collection('DateActivity').get();

  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  //   print(allData);
  // }

  Future<void> addHabit() async {
    // await activityRF
    //     .doc(_user.email.toString())
    //     .collection('DateActivity')
    //     .doc(todaysDateFormatted())
    //     .set({
    //       'date': todaysDateFormatted(),
    //       'completed': 0,
    //       'dummy_field': null,
    // },);

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

  // String getStartDate() {
  //   return _startDate!;
  // }

  // Map<DateTime, int> getDatabase() {
  //   return _databases!;
  // }

  Map<DateTime, int> getDateActivitiesMap() {
    return dateActivities.fold<Map<DateTime, int>>({}, (map, dateActivity) {
      final date = createDateTimeObject(dateActivity.date);
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
