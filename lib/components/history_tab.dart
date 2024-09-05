import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/widgets/bar_chart_widget.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BarChartWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Container(
            child: objectBox.getWeeklyWaterDrunk() != 0
                ? Text(
                    'Weekly Average: ${(objectBox.getWeeklyWaterDrunk() / 7).toStringAsFixed(0)} ml/day',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: CupertinoColors.systemIndigo,
                    ),
                  )
                : Text(''),
          ),
        ),
      ],
    );
  }
}
