import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatmapCalendarMonthTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return heatmapCalendarMonth();
  }

  Widget heatmapCalendarMonth() {
    return HeatMapCalendar(
        //startDate: startDate,
        initDate: DateTime.now(),
        //endDate: endDate,
        monthFontSize: 24,
        weekFontSize: 16,
        //datasets: headacheMap,
        flexible: true,
        //showText: true,
        //scrollable: true,
        fontSize: 18,
        pastOnly: true,
        earliestYearToDisplay: 2023,
        showColorTip: true,
        colorTipCount: 10,
        colorTipAlignment: MainAxisAlignment.center,
        colorTipSize: 15,
        defaultColor: Colors.grey[200]!,
        size: 45,
        colorTipHelper: const [
          Text(
            "Low Intensity  ",
            style: TextStyle(fontSize: 14),
          ),
          Text("  High Intensity", style: TextStyle(fontSize: 14)),
        ],
        colorsets: const {
          1: Color.fromARGB(20, 251, 43, 28),
          2: Color.fromARGB(40, 251, 43, 28),
          3: Color.fromARGB(60, 251, 43, 28),
          4: Color.fromARGB(80, 251, 43, 28),
          5: Color.fromARGB(100, 251, 43, 28),
          6: Color.fromARGB(120, 251, 43, 28),
          7: Color.fromARGB(150, 251, 43, 28),
          8: Color.fromARGB(180, 251, 43, 28),
          9: Color.fromARGB(210, 251, 43, 28),
          10: Color.fromARGB(255, 251, 43, 28),
        });
  }
}
