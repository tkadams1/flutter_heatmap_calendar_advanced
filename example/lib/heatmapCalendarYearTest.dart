import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatmapCalendarYearTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return heatmapCalendarYear(context);
  }

  Widget heatmapCalendarYear(context) {
    return HeatMapCalendarYear(
      selectedYear: 2020,
      earliestYearToDisplay: 2019,
      //monthFontSize: 24,
      yearFontSize: 24,
      datasets: {DateTime.now(): 1},
      //flexible: true,
      showText: true,
      scrollable: false,
      segmented: true,
      pastOnly: true,
      staticWeekdayLabels: true,
      showColorTip: true,
      defaultColor: Colors.grey[200]!,
      size: 20,
      colorTipAlignment: MainAxisAlignment.center,
      colorTipHelper: const [
        Text(
          "Low Intensity ",
        ),
        Text("  High Intensity"),
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
      },
      onClick: (value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.toString())));
      },
    );
  }
}
