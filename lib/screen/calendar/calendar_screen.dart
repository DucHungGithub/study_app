import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/configs/themes/custom_text_styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  static const String routeName = "/calendarscreen";

  @override
  State<CalendarScreen> createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  CalendarView _calendarView = CalendarView.week; // default view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customScaffoldColor(context),
      appBar: AppBar(
        title: const Text(
          'My Calendar',
          style: appBarTs
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _calendarView = CalendarView.day;
              });
            },
            tooltip: 'Day View',
            icon: SvgPicture.asset("assets/icons/calendar_view_day.svg"),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _calendarView = CalendarView.week;
              });
            },
            tooltip: 'Week View',
            icon: SvgPicture.asset("assets/icons/calendar_view_week.svg"),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _calendarView = CalendarView.month;
              });
            },
            tooltip: 'Month View',
            icon: SvgPicture.asset("assets/icons/calendar_view_month.svg"),
          ),
        ],
      ),
      body: SfCalendar(
        key: ValueKey(_calendarView),
        view: _calendarView,
      ),
    );
  }
}