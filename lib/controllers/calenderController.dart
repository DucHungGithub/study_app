import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/models/datetime.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'auth_controller.dart';

class TakeNoteController extends GetxController {
  final String _userMail =
      Get.find<AuthController>().getUser()!.email.toString();
  RxList<DateNote> dateNote =
      <DateNote>[].obs; //late Map<DateTime, String>? _databases;

  late Map<DateTime, DateNote> check;

  @override
  void onReady() async {
    print("Chay xong");
    await fetchData();
    check = getDateNoteMap();
    super.onReady();
  }

  Future<void> fetchData() async {
    final takeNoteRef =
        await takeNoteRF.doc(_userMail).collection("DateNote").get();
    dateNote.value =
        takeNoteRef.docs.map((doc) => DateNote.fromSnapshot(doc)).toList();

    for (var i in dateNote.value) {
      print(i.date);
    }
  }

  Future<DateNote> getDateNote(DateTime date) async {
    final dateGet = await takeNoteRF
        .doc(_userMail)
        .collection("DateNote")
        .doc(convertDateTimeToString(date))
        .get();
    if (dateGet.exists) {
      return DateNote.fromSnapshot(dateGet);
    }
    return DateNote(date: convertDateTimeToString(date), subject: "", note: "");
  }

  Future<void> addNote(DateTime date, String noteWrite, String subject) async {
    final takeNoteRef = takeNoteRF
        .doc(_userMail)
        .collection('DateNote')
        .doc(convertDateTimeToString(date));

    takeNoteRef.get().then((DocumentSnapshot docSnapshot) {
      takeNoteRef.set(
        {
          'date': convertDateTimeToString(date),
          'note': noteWrite,
          'subject': subject,
        },
      ); // create the document
    });

    if (check.containsKey(date)) {
      dateNote.remove(check[date]);
    }

    dateNote.add(DateNote(
        date: convertDateTimeToString(date),
        note: noteWrite,
        subject: subject));
  }

  List<Appointment> getAppointments() {
    List<Appointment> dateSet = <Appointment>[];
    Random random = Random();
    for (var i in dateNote.value) {
      final DateTime startTime = createDateTimeObject(i.date);
      final DateTime endTime = startTime;

      dateSet.add(Appointment(
        isAllDay: true,
        startTime: startTime,
        endTime: endTime,
        subject: i.subject,
        notes: i.note,
        color: Color.fromARGB(
            255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
      ));
    }

    return dateSet;
  }

  Map<DateTime, DateNote> getDateNoteMap() {
    return dateNote.fold<Map<DateTime, DateNote>>({}, (map, dateNote) {
      DateTime date = createDateTimeObject(dateNote.date);
      map[date] = dateNote;
      return map;
    });
  }
}

class DateNote {
  final String date;
  final String note;
  final String subject;

  DateNote({required this.date, required this.note, required this.subject});

  factory DateNote.fromDocument(DocumentSnapshot doc) {
    return DateNote(
      date: doc['date'],
      note: doc['note'],
      subject: doc['subject'],
    );
  }

  DateNote.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : date = json['date'],
        note = json['note'],
        subject = json['subject'];
}
