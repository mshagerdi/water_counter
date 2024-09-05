import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/models/water_counter_data.dart';
import 'package:water_counter/provider/water_counter_provider.dart';
import 'package:water_counter/resources/app_colors.dart';

class _BarChart extends StatelessWidget {
  _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: Provider.of<WaterCounterProvider>(context).dailyWaterAmount,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final nowDate = DateTime.now();
    String dateFormat(int sub) {
      return DateFormat.E().format(nowDate.subtract(Duration(days: sub)));
    }

    final style = TextStyle(
      color: AppColors.contentColorBlue.darken(20),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = dateFormat(7);
        break;
      case 1:
        text = dateFormat(6);
        break;
      case 2:
        text = dateFormat(5);
        break;
      case 3:
        text = dateFormat(4);
        break;
      case 4:
        text = dateFormat(3);
        break;
      case 5:
        text = dateFormat(2);
        break;
      case 6:
        text = dateFormat(1);
        break;

      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    int counter = 0;
    List<BarChartGroupData> barChartGroupList = [];

    List<WaterCounterData> dataList = [];

    dataList = objectBox.getWeeklyWaterCounterList();
    for (WaterCounterData data in dataList) {
      barChartGroupList.add(BarChartGroupData(
        x: counter++,
        barRods: [
          BarChartRodData(
            toY: data.amount,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }
    return barChartGroupList;
  }

// [
//   BarChartGroupData(
//     x: 0,
//     barRods: [
//       BarChartRodData(
//         toY: 8,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 1,
//     barRods: [
//       BarChartRodData(
//         toY: 10,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 2,
//     barRods: [
//       BarChartRodData(
//         toY: 14,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 3,
//     barRods: [
//       BarChartRodData(
//         toY: 15,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 4,
//     barRods: [
//       BarChartRodData(
//         toY: 13,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 5,
//     barRods: [
//       BarChartRodData(
//         toY: 10,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 6,
//     barRods: [
//       BarChartRodData(
//         toY: 16,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 7,
//     barRods: [
//       BarChartRodData(
//         toY: 16,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
// ];
}

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<StatefulWidget> createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(),
    );
  }
}
