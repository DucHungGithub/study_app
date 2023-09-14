import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class TrackerMap extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final DateTime startDate;

  const TrackerMap({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: startDate,
        endDate: DateTime.now().add(const Duration(days: 30)),
        datasets: datasets,
        colorMode: ColorMode.color,
        textColor: Colors.black,
        showColorTip: true,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromRGBO(2, 179, 8, 0.1),
          2: Color.fromRGBO(2, 179, 8, 0.2),
          3: Color.fromRGBO(2, 179, 8, 0.3),
          4: Color.fromRGBO(2, 179, 8, 0.4),
          5: Color.fromRGBO(2, 179, 8, 0.5),
          6: Color.fromRGBO(2, 179, 8, 0.6),
          7: Color.fromRGBO(2, 179, 8, 0.7),
          8: Color.fromRGBO(2, 179, 8, 0.8),
          9: Color.fromRGBO(2, 179, 8, 0.9),
          10: Color.fromRGBO(2, 179, 8, 1.0),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
