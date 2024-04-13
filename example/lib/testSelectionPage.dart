import 'package:flutter/material.dart';
import 'package:flutter_heatmap_example/heatmapCalendarYearTest.dart';
import 'package:flutter_heatmap_example/heatmapCalendarMonthTest.dart';

class testSelectionPage extends StatefulWidget {
  @override
  _testSelectionPageState createState() => _testSelectionPageState();
}

class _testSelectionPageState extends State<testSelectionPage> {
  bool pageIndex = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => setState(() {
                  pageIndex = !pageIndex;
                }),
            child: Text("Heatmap Calendar")),
        pageIndex ? HeatmapCalendarMonthTest() : HeatmapCalendarYearTest(),
      ],
    );
  }
}
