import 'package:flutter/material.dart';
import './widget/heatmap_page.dart';
import './widget/heatmap_color_tip.dart';
import './widget/heatmap_week_text.dart';
import './data/heatmap_color_mode.dart';
import './util/date_util.dart';

class HeatMapCalendarYear extends StatefulWidget {
  /// The Date value of start day of heatmap.
  ///
  /// HeatMap shows the start day of [startDate]'s week.
  ///
  /// Default value is 1 year before of the [endDate].
  /// And if [endDate] is null, then set 1 year before of the [DateTime.now].
  final int selectedYear;

  /// The Date value of end day of heatmap.
  ///
  /// Default value is [DateTime.now].
  final int? earliestYearToDisplay;

  /// The datasets which fill blocks based on its value.
  final Map<DateTime, int>? datasets;

  /// The color value of every block's default color.
  final Color? defaultColor;

  /// The text color value of every blocks.
  final Color? textColor;

  /// The double value of every block's size.
  final double? size;

  /// The double value of every block's fontSize.
  final double? fontSize;

  /// The double value of every block's fontSize.
  final double? yearFontSize;

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  /// Also colorsets must have at least one color.
  final Map<int, Color> colorsets;

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  ///
  /// Default value is [ColorMode.opacity].
  final ColorMode colorMode;

  /// Function that will be called when a block is clicked.
  ///
  /// Parameter gives clicked [DateTime] value.
  final Function(DateTime)? onClick;

  /// The margin value for every block.
  final EdgeInsets? margin;

  /// The double value of every block's borderRadius.
  final double? borderRadius;

  /// Show day text in every blocks if the value is true.
  ///
  /// Default value is false.
  final bool? showText;

  /// Show color tip which represents the color range at the below.
  ///
  /// Default value is true.
  final bool? showColorTip;

  /// Makes heatmap scrollable if the value is true.
  ///
  /// default value is false.
  final bool scrollable;

  final bool pastOnly;

  final bool staticWeekdayLabels;

  final bool segmented;

  /// Widgets which shown at left and right side of colorTip.
  ///
  /// First value is the left side widget and second value is the right side widget.
  /// Be aware that [colorTipHelper.length] have to greater or equal to 2.
  /// Give null value makes default 'less' and 'more' [Text].
  final List<Widget?>? colorTipHelper;

  final MainAxisAlignment? colorTipAlignment;

  /// The integer value which represents the number of [HeatMapColorTip]'s tip container.
  final int? colorTipCount;

  /// The double value of [HeatMapColorTip]'s tip container's size.
  final double? colorTipSize;

  final int? heatMapInitialYear;

  const HeatMapCalendarYear({
    Key? key,
    required this.colorsets,
    this.colorMode = ColorMode.opacity,
    required this.selectedYear,
    this.earliestYearToDisplay = 2000,
    this.textColor,
    this.size = 20,
    this.fontSize,
    this.yearFontSize = 20,
    this.onClick,
    this.margin,
    this.borderRadius,
    this.datasets,
    this.defaultColor,
    this.showText = false,
    this.showColorTip = true,
    this.scrollable = false,
    this.segmented = false,
    this.colorTipHelper,
    this.colorTipAlignment,
    this.colorTipCount,
    this.colorTipSize,
    this.heatMapInitialYear,
    this.pastOnly = false,
    this.staticWeekdayLabels = true,
  }) : super(key: key);
  @override
  _HeatMapCalendarYearState createState() => _HeatMapCalendarYearState();
}

class _HeatMapCalendarYearState extends State<HeatMapCalendarYear> {
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.selectedYear;
  }

  Widget _scrollableHeatMap(Widget child) {
    return widget.scrollable
        ? SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: child,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return widget.segmented
        ? _segmentedHeatMapCalendarYear()
        : _scrollableHeatmapCalendarYear();
  }

  Widget _scrollableHeatmapCalendarYear() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Heatmap Widget.
        _header(),
        Row(
          children: [
            //This puts the week labels to the left of the heatmap regardless of scroll position
            _staticWeekDayLabels(),
            Expanded(
              child: Container(
                child: _scrollableHeatMap(HeatMapPage(
                  endDate: selectedYear == DateTime.now().year
                      ? DateTime.now()
                      : DateTime(selectedYear, 12, 31),
                  startDate: DateTime(selectedYear, 1, 1),
                  colorMode: widget.colorMode,
                  size: widget.size,
                  fontSize: widget.fontSize,
                  datasets: widget.datasets,
                  defaultColor: widget.defaultColor,
                  textColor: widget.textColor,
                  colorsets: widget.colorsets,
                  borderRadius: widget.borderRadius,
                  onClick: widget.onClick,
                  margin: widget.margin,
                  showText: widget.showText,
                  staticWeekdayLabels: widget.staticWeekdayLabels,
                )),
              ),
            ),
          ],
        ),

        // Show HeatMapColorTip if showColorTip is true.
        if (widget.showColorTip == true)
          HeatMapColorTip(
            colorMode: widget.colorMode,
            colorsets: widget.colorsets,
            leftWidget: widget.colorTipHelper?[0],
            rightWidget: widget.colorTipHelper?[1],
            containerCount: widget.colorTipCount,
            alignment: widget.colorTipAlignment,
            size: widget.colorTipSize,
          ),
      ],
    );
  }

  Widget _segmentedHeatMapCalendarYear() {
    DateTime segment1Start = DateTime(selectedYear, 1, 1);
    DateTime segment1End = DateTime(selectedYear, 4, 1).subtract(const Duration(days: 1));
    DateTime segment2Start = DateTime(selectedYear, 4, 1);
    DateTime segment2End = DateTime(selectedYear, 7, 1).subtract(const Duration(days: 1));
    DateTime segment3Start = DateTime(selectedYear, 7, 1);
    DateTime segment3End = DateTime(selectedYear, 10, 1).subtract(const Duration(days: 1));
    DateTime segment4Start = DateTime(selectedYear, 10, 1);
    DateTime segment4End = DateTime(selectedYear, 12, 31);

    bool segment2Enabled = DateTime.now().isAfter(segment2Start);
    bool segment3Enabled = DateTime.now().isAfter(segment3Start);
    bool segment4Enabled = DateTime.now().isAfter(segment4Start);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Heatmap Widget.
        _header(),
        _heatmapSegment(segment1Start, segment1End),
        segment2Enabled
        ? _heatmapSegment(segment2Start, segment2End)
        : const SizedBox.shrink(),
                segment3Enabled
        ? _heatmapSegment(segment3Start, segment3End)
        : const SizedBox.shrink(),
                segment4Enabled
        ? _heatmapSegment(segment4Start, segment4End)
        : const SizedBox.shrink(),
        if (widget.showColorTip == true)
              HeatMapColorTip(
                colorMode: widget.colorMode,
                colorsets: widget.colorsets,
                leftWidget: widget.colorTipHelper?[0],
                rightWidget: widget.colorTipHelper?[1],
                containerCount: widget.colorTipCount,
                alignment: widget.colorTipAlignment,
                size: widget.colorTipSize,
              ),
      ],
    );
  }

  Widget _heatmapSegment(DateTime startDate, DateTime endDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //This puts the week labels to the left of the heatmap regardless of scroll position
        _staticWeekDayLabels(),
        HeatMapPage(
          endDate: endDate,
          startDate: startDate,
          colorMode: widget.colorMode,
          size: widget.size,
          fontSize: widget.fontSize,
          datasets: widget.datasets,
          defaultColor: widget.defaultColor,
          textColor: widget.textColor,
          colorsets: widget.colorsets,
          borderRadius: widget.borderRadius,
          onClick: widget.onClick,
          margin: widget.margin,
          showText: widget.showText,
          staticWeekdayLabels: widget.staticWeekdayLabels,
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Previous month button.
        _buildPastIconButton(),

        // Text which shows the current year and month
        Text(
          (selectedYear).toString(),
          style: TextStyle(
            fontSize: widget.yearFontSize ?? 12,
          ),
        ),

        // Next month button.
        _buildForwardIconButton(),
      ],
    );
  }

  void _changeYear(int year) {
    setState(() {
      selectedYear = year;
    });
  }

  Widget _staticWeekDayLabels() {
    return widget.staticWeekdayLabels
        ? HeatMapWeekText(
            margin: widget.margin,
            fontSize: widget.fontSize,
            size: widget.size,
            fontColor: widget.textColor,
          )
        : const SizedBox.shrink();
  }

}
