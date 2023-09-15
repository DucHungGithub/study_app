import 'package:flutter/material.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/configs/themes/custom_text_styles.dart';
import 'package:study_app_project/screen/calendar/calenderPickNote.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

import '../../controllers/calenderController.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static const String routeName = "/calendarscreen";

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var calendarView = CalendarView.month;

  final controller = Get.find<TakeNoteController>();

  void openAddNoteOverlay(DateTime dateNow) {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => GetNote(
              dateNow: dateNow,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customScaffoldColor(context),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  tooltip: 'Month View',
                  icon: const Icon(Icons.arrow_back, size: 20),
                ),
                const Text('My Calendar', style: appBarTs),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => SfCalendar(
                  view: calendarView,
                  dataSource: EventDataSource(controller.getAppointments()),
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                  onTap: (calendarTapDetails) {
                    if (controller.check.containsKey(calendarTapDetails.date)) {
                      final data = controller.check[calendarTapDetails.date]!;
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                  data.subject,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  data.note,
                                  style: detailText,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                          openAddNoteOverlay(
                                              calendarTapDetails.date!);
                                        });
                                      },
                                      child: const Text("Change")),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Close"))
                                ],
                              ));
                    } else {
                      openAddNoteOverlay(calendarTapDetails.date!);
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
